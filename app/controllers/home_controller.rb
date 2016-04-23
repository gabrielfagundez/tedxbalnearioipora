class HomeController < ApplicationController

  def index
    @favorite_projects = current_user.favorite_projects.collect(&:project)

    projects = Project.where(client_id: current_user.clients.collect(&:id))
    @upcoming_project_events = ProjectEvent.order('expected_date').where(project_id: projects.collect(&:id)).where("expected_date > ?", Time.now.utc).limit(3)

    @upcoming_user_events = UserEvent.order('start_date').all
  end

end
