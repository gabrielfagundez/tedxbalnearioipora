class UpcomingEventsController < ApplicationController

  def index
    @users = current_account.users
    @projects = Project.where(client_id: current_user.clients.collect(&:id))
    @clients = current_account.clients

    @upcoming_user_events = UserEvent.where(user_id: current_account.users.collect(&:id)).order('start_date').all

    projects = Project.where(client_id: current_user.clients.collect(&:id))
    @upcoming_project_events = ProjectEvent.order('expected_date').where(project_id: projects.collect(&:id)).where("expected_date > ?", Time.now.utc).limit(3)
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
