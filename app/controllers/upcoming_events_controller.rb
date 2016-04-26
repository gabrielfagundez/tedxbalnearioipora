class UpcomingEventsController < ApplicationController

  def index
    @users = current_account.users
    @projects = Project.where(client_id: current_user.clients.collect(&:id))
    @clients = current_account.clients
    @upcoming_user_events = UserEvent.order('start_date').all
  end

  def create
    if params[:type] == 'project_event'
      ProjectEvent.create(upcoming_events_params)
    elsif params[:type] == 'user_event'
      UserEvent.create(upcoming_events_params)
    end

    redirect_to upcoming_events_path
  end

  private

  def upcoming_events_params
    params.require(:event).permit(:name, :description, :event_type, :start_date, :end_date, :user_id, :expected_date, :project_id)
  end

end
