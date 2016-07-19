class Api::ProjectsController < Api::ApiController

  def index
    render json: Project.where(client_id: current_user.clients.collect(&:id)).map{ |p| p.pretty_data }.to_json
  end

  def time_usage
    render json: Project.find(params[:id]).time_usage(current_account.time_categories.collect(&:name)).to_json
  end

  def total_time
    render json: Project.find(params[:id]).total_time.to_json
  end

  def radar
    render json: Project.find(params[:id]).radar.to_json
  end

  def historical
    render json: Project.find(params[:id]).historical.to_json
  end

  def velocity
    render json: Project.find(params[:id]).velocity.to_json
  end

end
