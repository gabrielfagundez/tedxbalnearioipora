class Api::ApiController < ActionController::Base

  def current_account
    @current_account ||= current_user.account
  end

end
