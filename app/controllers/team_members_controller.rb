class TeamMembersController < ApplicationController

  before_filter :check_auth
  before_filter :set_tm, only: [:edit, :update]

  def index
    @team_members = TeamMember.all
  end

  def summary
    render json: TeamMember.find(params[:id]).summary.to_json
  end

  def show
    @team_member = TeamMember.find(params[:id])
  end

  def new
    @team_member = TeamMember.new
    @projects = Project.all
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

  def create
    @team_member = TeamMember.new(tm_params)

    if @team_member.save
      params[:projects].each do |project_id|
        @team_member.projects << Project.find(project_id)
      end if params[:projects].present?
      redirect_to team_members_path
    else
      render :new
    end
  end

  private

  def tm_params
    params.require(:team_member).permit(:name, :role)
  end

  def set_tm
    @team_member = TeamMember.find(params[:id])
  end

  def check_auth
    redirect_to root_path if cannot? :manage, :team_members
  end

end
