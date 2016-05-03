class Api::UsersController < Api::ApiController

  def index
    render json: User.where(account_id: current_account.id).to_json
  end

end
