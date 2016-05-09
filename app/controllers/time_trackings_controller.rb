class TimeTrackingsController < ApplicationController

  def show
    @clients = current_user.clients.includes(:projects)
    @categories = current_account.time_categories.all
  end

end
