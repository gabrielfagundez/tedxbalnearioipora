class UpcomingEventsController < ApplicationController

  def index
    @upcoming_user_events = UserEvent.order('start_date').all
  end

  private

  def upcoming_events_params
  end

end
