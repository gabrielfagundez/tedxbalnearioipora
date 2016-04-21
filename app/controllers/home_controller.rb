class HomeController < ApplicationController

  def index
    @favorite_projects = current_user.favorite_projects.collect(&:project)
  end

end
