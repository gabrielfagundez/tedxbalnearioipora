class Api::TimeEntriesController < Api::ApiController

  before_filter :sanitize_time_entry_params

  def index
    render json: current_user.time_entries.last_7_days.closed.by_started_at.map{ |te| te.pretty_data }
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
