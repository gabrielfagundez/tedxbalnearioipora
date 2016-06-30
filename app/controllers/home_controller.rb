class HomeController < ApplicationController

  def index
    @last_week_hours = 0
    @people_in_this_acct = current_account.users.length
  end

end
