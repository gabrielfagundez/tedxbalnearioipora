class HomeController < ApplicationController

  def index
    @favourite_projects = current_user.favourite_projects.collect(&:project)
  end

end
