class HomeController < ApplicationController

  def index
    @account_info = {
      last_week_hours: current_account.last_week_hours,
      users_count: current_account.users_count
    }
  end

end
