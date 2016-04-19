class TimeTrackingsController < ApplicationController

  before_filter :check_beta

  def show
    @clients = current_user.clients.includes(:projects)
    @categories = [
      '1 - Communication/Management',
      '2 - Development',
      '3 - Development (bug)',
      '4 - Development (code review)',
      '5 - QA',
      '6 - Infrastructure',
      '7 - UX/UI',
    ]
  end

end
