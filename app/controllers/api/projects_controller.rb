class Api::ProjectsController < Api::ApiController

  def index
    render json: Project.where(client_id: current_user.clients.collect(&:id)).map{ |p| p.pretty_data }.to_json
  end

  def toggle_fav
    favorite = FavoriteProject.where(project_id: params[:id], user_id: current_user.id).first
    if favorite.present?
      favorite.delete
    else
      FavoriteProject.create(project_id: params[:id], user_id: current_user.id)
    end

    render json: {}.to_json
  end

end
