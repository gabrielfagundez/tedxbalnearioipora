class ProjectsController < ApplicationController

  def index
    @clients = Client.all.includes(:projects)
  end

  def show
    @project = Project.find(params[:id])
  end

  def work_entries
    @project = Project.find(params[:id])
    @team_members = TeamMember.all
  end

end
