class StoryPointsController < ApplicationController

  def create
    StoryPoint.create(story_points_params.merge(project_id: params[:project_id]))
    redirect_to team_performance_project_path(params[:project_id])
  end

  def destroy
    StoryPoint.find(params[:id]).delete
    redirect_to team_performance_project_path(params[:project_id])
  end

  private

  def story_points_params
    params.require(:story_point).permit(:value, :definition)
  end

end
