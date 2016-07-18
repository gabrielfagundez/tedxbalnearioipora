class Project < ActiveRecord::Base

  NULL_ATTRS = %w( hired_hours expected_hours contract_end_date mision vision daily_meeting retrospectives iteration_planning estimates_model issue_tracker )
  before_save :nil_if_blank

  has_many :weekly_entries
  has_many :time_entries
  has_many :points_completed_entries
  has_many :versions
  has_many :favorite_projects
  has_many :widgets
  has_many :project_events
  has_many :story_points
  belongs_to :team_leader, class_name: 'User'
  belongs_to :client
  has_and_belongs_to_many :team_members

  def stats
    @stats ||= {
      avg_four_weeks: average_four_weeks.round(1),
      remaining_weeks: hired_hours.present? ? ((hired_hours - used_hours) / average_four_weeks).round(1) : nil,
      contract_end_date: contract_end_date || "~",
      expected_hours: expected_hours.present? ? expected_hours : "~",
      this_week: { hours: self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 1.week).to_s, week: "Last week: #{(Date.today.beginning_of_week(:monday) - 1.week).to_s}" }
    }
  end

  def velocity_frequency
    if self.velocity_frequency_in_days == 7
      "weekly"
    elsif self.velocity_frequency_in_days == 14
      "every 2 weeks"
    else
      "every #{ self.velocity_frequency_in_days } days"
    end
  end

  def pretty_data
    {
      id: self.id,
      name: self.name,
      client_name: self.client.name,
      color: self.color
    }
  end

  def summary_text
    self.summary || "<i>The project hasn't a summary yet</i>".html_safe
  end

  def used_hours
    self.weekly_entries.map{ |we| we.communication + we.development + we.bugs + we.code_review + we.qa + we.infraestructure + we.uxui }.sum().to_f
  end

  def client_name
    self.client.name
  end

  def average_four_weeks
    @average_four_weeks ||=
      (self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 1.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 2.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 3.week) +
      self.total_hours_for_week(Date.today.beginning_of_week(:monday) - 4.week)) / 4
  end

  def velocity
    ProjectVelocityChart.new(self).chart_data
  end

  def total_time
    ProjectTotalTimeChart.new(self).chart_data
  end

  def radar
    ProjectRadarChart.new(self).chart_data
  end

  def time_usage(categories)
    ProjectTimeUsageChart.new(self, categories).chart_data
  end

  def historical
    ProjectHistoricalChart.new(self).chart_data
  end

  def average(value, total)
    if total == 0.0
      0
    else
      (value * 100 / total).round(1)
    end
  end

  def total_hours_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.communication + we.development + we.bugs + we.code_review + we.qa + we.infraestructure + we.uxui }.sum().to_f
  end

  def total_communication_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.communication }.sum().to_f
  end

  def total_development_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.development }.sum().to_f
  end

  def total_bugs_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.bugs }.sum().to_f
  end

  def total_code_review_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.code_review }.sum().to_f
  end

  def total_qa_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.qa }.sum().to_f
  end

  def total_infraestructure_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.infraestructure }.sum().to_f
  end

  def total_uxui_for_week(week)
    self.weekly_entries.where(week: week).map{ |we| we.uxui }.sum().to_f
  end

  protected

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
