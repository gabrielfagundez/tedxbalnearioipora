class TimeTrackingsController < ApplicationController

  before_filter :check_beta

  def show
    @clients = current_user.clients.includes(:projects)
    @categories = TimeCategory.all
  end

end
