class Api::TimeCategoriesController < Api::ApiController

  def index
    render json: current_account.time_categories.to_json
  end

end
