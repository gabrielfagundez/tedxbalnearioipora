class Api::ProjectsController < Api::ApiController

  def index
    render json: Project.where(client_id: current_user.clients.collect(&:id)).map{ |p| p.pretty_data }.to_json
  end

end
