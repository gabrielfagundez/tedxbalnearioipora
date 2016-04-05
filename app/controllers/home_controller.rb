class HomeController < ApplicationController

  def index
    @favourite_projects = Project.favourites
  end

end
