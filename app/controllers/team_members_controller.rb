class TeamMembersController < ApplicationController

  before_filter :set_tm, only: [:edit, :update]

  def index
    @team_members = TeamMember.all
  end

  def edit
    @projects = Project.all
  end

  def update
    if @team_member.update_attributes(tm_params)
      @team_member.update_attribute(:projects, [])
      params[:projects].each do |project_id|
        @team_member.projects << Project.find(project_id)
      end
      redirect_to team_members_path
    else
      render :edit
    end
  end

  private

  def tm_params
    params.require(:team_member).permit(:name, :role)
  end

  def set_tm
    @team_member = TeamMember.find(params[:id])
  end

end
