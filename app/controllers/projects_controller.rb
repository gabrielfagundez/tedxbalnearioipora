class ProjectsController < ApplicationController

  def index
    @clients = Client.all.includes(:projects)
  end

  def show
    @project = Project.find(params[:id])
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

  def work_entries
    @project = Project.find(params[:id])
    @team_members = TeamMember.all
  end

  def enter_work_entries
    sanitized_entries = sanitize_entries

    sanitize_entries.keys.each do |user_id|
      WeeklyEntry.create(
        team_member_id: user_id,
        project_id: params[:id],
        week: Date.today.beginning_of_week(:monday).to_s,
        communication: sanitized_entries[user_id]["1"].present? ? sanitized_entries[user_id]["1"].to_f : 0,
        development: sanitized_entries[user_id]["2"].present? ? sanitized_entries[user_id]["2"].to_f : 0,
        bugs: sanitized_entries[user_id]["3"].present? ? sanitized_entries[user_id]["3"].to_f : 0,
        code_review: sanitized_entries[user_id]["4"].present? ? sanitized_entries[user_id]["4"].to_f : 0,
        qa: sanitized_entries[user_id]["5"].present? ? sanitized_entries[user_id]["5"].to_f : 0,
        infraestructure: sanitized_entries[user_id]["6"].present? ? sanitized_entries[user_id]["6"].to_f : 0,
        uxui: sanitized_entries[user_id]["7"].present? ? sanitized_entries[user_id]["7"].to_f : 0)
    end

    redirect_to projects_path
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

end
