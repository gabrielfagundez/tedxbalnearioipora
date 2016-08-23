class ProjectsController < ApplicationController

  before_filter :set_project,                 only: [:show, :velocity, :hours, :edit, :update]
  before_filter :set_favorite_project,        only: [:show, :velocity, :hours]
  before_filter :sanitize_params,             only: [:update]
  before_filter :process_velocity_registers,  only: [:update]

  def index
    @clients = current_user.visible_clients
    @favorites = FavoriteProject.where(user_id: current_user.id).collect(&:project_id)
  end

  def show
  end

  def velocity
  end

  def hours
  end

  def edit
    @users = @project.client.users.all
  end

  def update
    @project.update_attributes(project_params)
    @project.update_attributes(billable: params[:project][:billable] == 'billable') if params[:project].present? && params[:project][:billable].present?

    redirect_to project_path(params[:id])
  end

  def favorite
    favorite = FavoriteProject.where(project_id: params[:id], user_id: current_user.id).first
    favorite.delete if favorite.present?
    FavoriteProject.create(project_id: params[:id], user_id: current_user.id) if favorite.blank?

    redirect_to project_path(params[:id])
  end

  # =========== =========== =========== ===========
  # TODO: Logic TBR when time tracking is ready
  def work_entries
    @project = Project.find(params[:id])
    @categories = @project.client.account.time_categories
    @users = @project.client.users.all
  end

  def enter_work_entries
    params[:entries].each do |entry|
      user_id = entry[0].split("--")[0]
      time_entry_id = entry[0].split("--")[1]
      time_entry_value = entry[1]

      if time_entry_value.present?
        TimeEntry.create(
          user_id:            user_id,
          project_id:         params[:id],
          description:        "Weekly Entry",
          time_category_id:   time_entry_id,
          started_at:         params[:week].to_datetime,
          ended_at:           params[:week].to_datetime + time_entry_value.to_i.hours
        )
      end
    end

    redirect_to project_path(params[:id])
  end
  # =========== =========== =========== ===========

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_favorite_project
    @favorite = FavoriteProject.where(project_id: params[:id], user_id: current_user.id).first
  end

  def project_params
    if params[:project].present?
      params.require(:project).permit(
        :name, :mision, :color, :vision, :team_leader_id, :code_review_model, :hired_hours,
        :expected_hours, :contract_end_date, :daily_meeting, :retrospectives, :iteration_planning,
        :estimates_model, :issue_tracker, :summary
      )
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

  def process_velocity_registers
    if params[:velocity_registers].present?
      VelocityRegister.create(
        start_date: params[:velocity_registers][:start_date],
        period: params[:velocity_registers][:period],
        points: params[:velocity_registers][:points].to_i,
        project_id: params[:id]
      )
    end
  end

end
