class Project < ActiveRecord::Base

  NULL_ATTRS = %w( expected_hours contract_end_date mision vision daily_meeting retrospectives iteration_planning estimates_model issue_tracker )
  before_save :nil_if_blank

  has_many :time_entries
  has_many :velocity_registers, -> { order("start_date DESC") }
  has_many :versions
  has_many :favorite_projects
  has_many :project_events
  has_many :story_points
  belongs_to :team_leader, class_name: 'User'
  belongs_to :client

  def next_velocity_register_date
    ProjectVelocity.new(self).next_velocity_register_date
  end

  def avg_velocity_over_10_periods
    ProjectVelocity.new(self).avg_velocity(10)
  end

  def min_velocity_over_10_periods
    ProjectVelocity.new(self).min_velocity(10)
  end

  def max_velocity_over_10_periods
    ProjectVelocity.new(self).max_velocity(10)
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

  def weekly_velocity?
    self.velocity_frequency_in_days == 7
  end

  def biweekly_velocity?
    self.velocity_frequency_in_days == 14
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

  def client_name
    self.client.name
  end

  def velocity
    ProjectVelocityChart.new(self).chart_data
  end

  def velocity_progress(months)
    ProjectVelocityProgressChart.new(self).chart_data(months)
  end

  def total_time
    ProjectTotalTimeChart.new(self).chart_data
  end

  def time_usage
    ProjectTimeUsageChart.new(self).chart_data
  end

  def stats
    ProjectStats.new(self).build_stats
  end

  protected

  def nil_if_blank
    NULL_ATTRS.each { |attr| self[attr] = nil if self[attr].blank? }
  end

end
