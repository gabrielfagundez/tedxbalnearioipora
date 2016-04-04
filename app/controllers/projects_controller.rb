class ProjectsController < ApplicationController

  def index
    @clients = Client.all.includes(:projects)
  end

end
