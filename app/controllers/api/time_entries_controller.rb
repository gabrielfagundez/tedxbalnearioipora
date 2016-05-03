class Api::TimeEntriesController < Api::ApiController

  before_filter :sanitize_time_entry_params

  def index
    time_entries = current_user.time_entries.closed.by_started_at
    time_entries = time_entries.where(project_id: params[:projects].split(',')) if params[:projects].present?
    time_entries = time_entries.where(time_category_id: params[:time_categories].split(',')) if params[:time_categories].present?
    time_entries = time_entries.where(user_id: params[:users].split(',')) if params[:users].present?

    render json: time_entries.map{ |te| te.pretty_data }
  end

  def last_open
    last_entry = current_user.time_entries.last
    if last_entry.ended_at == nil
      render json: last_entry.pretty_data
    else
      render json: nil
    end
  end

  def show
  end

  def create
    te = TimeEntry.create(time_entry_params.merge(user_id: current_user.id, started_at: DateTime.now.utc))
    render json: te.to_json
  end

  def update
    te = TimeEntry.find(params[:id]).update_attributes(time_entry_params)
    render json: te.to_json
  end

  def destroy
    te = TimeEntry.find(params[:id]).delete
    render json: {}
  end

  def continue
    te = TimeEntry.find(params[:id])
    new_te = TimeEntry.create(user_id: current_user.id, project_id: te.project_id, description: te.description, time_category_id: te.time_category_id, billable: te.billable, started_at: DateTime.now.utc)
    render json: te.to_json
  end

  def close
    te = TimeEntry.find(params[:id])
    te.update_attributes(time_entry_params.merge(ended_at: DateTime.now.utc))

    render json: te.to_json
  end

  private

  def time_entry_params
    params.require(:time_entry_data).permit(:project_id, :time_category_id, :billable, :description)
  end

  def sanitize_time_entry_params
    params[:time_entry_data][:billable] = true if params[:time_entry_data] && params[:time_entry_data][:billable] && params[:time_entry_data][:billable] == 'billable'
  end

end
