class ProjectsController < ApplicationController

  before_filter :sanitize_params, only: :update
  before_filter :process_points_completed_entries

  def index
    @clients =
      params[:client_id].present? ?
        current_user.clients.includes(:projects).where(id: params[:client_id]) :
        current_user.clients.includes(:projects)
  end

  def show
    @project = Project.find_by_id(params[:id])
    redirect_to projects_path if @project.blank? || !(@project.client.users.collect(&:id).include?(current_user.id))

    @favorite = FavoriteProject.where(project_id: params[:id], user_id: current_user.id).first
  end

  def velocity_entries
    @project = Project.find_by_id(params[:id])
  end

  def create
    project = Project.create(project_params)
    project.client_id = params[:client_id]
    project.save

    redirect_to projects_path
  end

  def edit
    @project = Project.find_by_id(params[:id])
    @account = current_account
    redirect_to projects_path if @project.blank? || !(@project.client.users.collect(&:id).include?(current_user.id))

    @users = @project.client.users.all
  end

  def update
    project = Project.find(params[:id])
    project.update_attributes(project_params)
    project.update_attributes(billable: params[:project][:billable] == 'billable') if params[:project].present? && params[:project][:billable].present?

    redirect_to project_path(project)
  end

  def favorite
    favorite = FavoriteProject.where(project_id: params[:id], user_id: current_user.id).first
    if favorite.present?
      favorite.delete
    else
      FavoriteProject.create(project_id: params[:id], user_id: current_user.id)
    end

    redirect_to project_path(params[:id])
  end

  def summary
    render json: Project.find(params[:id]).summary.to_json
  end

  def radar
    render json: Project.find(params[:id]).radar.to_json
  end

  def historical
    render json: Project.find(params[:id]).historical.to_json
  end

  def overview
    render json: Project.find(params[:id]).overview.to_json
  end

  def velocity
    render json: Project.find(params[:id]).velocity.to_json
  end

  def work_entries
    @project = Project.find(params[:id])
    @users = @project.client.users.all
  end

  def enter_work_entries
    sanitized_entries = sanitize_entries

    sanitize_entries.keys.each do |user_id|
      WeeklyEntry.create(
        user_id: user_id,
        project_id: params[:id],
        week: params[:week],
        communication: sanitized_entries[user_id]["1"].present? ? sanitized_entries[user_id]["1"].to_f : 0,
        development: sanitized_entries[user_id]["2"].present? ? sanitized_entries[user_id]["2"].to_f : 0,
        bugs: sanitized_entries[user_id]["3"].present? ? sanitized_entries[user_id]["3"].to_f : 0,
        code_review: sanitized_entries[user_id]["4"].present? ? sanitized_entries[user_id]["4"].to_f : 0,
        qa: sanitized_entries[user_id]["5"].present? ? sanitized_entries[user_id]["5"].to_f : 0,
        infraestructure: sanitized_entries[user_id]["6"].present? ? sanitized_entries[user_id]["6"].to_f : 0,
        uxui: sanitized_entries[user_id]["7"].present? ? sanitized_entries[user_id]["7"].to_f : 0)
    end

    redirect_to project_path(params[:id])
  end

  private

  def sanitize_entries
    entries = params[:entries]
    sanitized_entries = {}
    entries.each do |entry|
      user_id = entry[0].split("--")[0]
      tag_id = entry[0].split("--")[1]
      tag_value = entry[1]

      if tag_value.present?
        if sanitized_entries[user_id].blank?
          sanitized_entries[user_id] = {}
        end
        sanitized_entries[user_id][tag_id] = tag_value if tag_value.present?
      end
    end

    sanitized_entries
  end

  def project_params
    if params[:project].present?
      params.require(:project).permit(:name, :mision, :color, :vision, :team_leader_id, :code_review_model, :hired_hours, :expected_hours, :contract_end_date ,:daily_meeting, :retrospectives, :iteration_planning, :estimates_model, :issue_tracker)
    else
      {}
    end
  end

  def sanitize_params
    return unless params[:project].present?

    params[:project][:hired_hours] = params[:project][:hired_hours].to_i if params[:project][:hired_hours].present?
    params[:project][:expected_hours] = params[:project][:expected_hours].to_i if params[:project][:expected_hours].present?
    params[:project][:team_leader_id] = params[:project][:team_leader_id].to_i if params[:project][:team_leader_id].present?
  end

  def process_points_completed_entries
    if params[:points_completed_entries].present?
      PointsCompletedEntry.create(
        period: params[:points_completed_entries][:period],
        points_completed: params[:points_completed_entries][:points_completed].to_i,
        project_id: params[:id]
      )
    end
  end

end
