class TimeEntry < ActiveRecord::Base

  DAYS = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  belongs_to :project
  belongs_to :user
  belongs_to :time_category

  before_save :set_duration

  def self.closed
    where.not(ended_at: nil)
  end

  def self.by_started_at
    order("started_at DESC")
  end

  def self.last_7_days
    where("started_at > ?", Time.now - 7.days)
  end

  def pretty_data
    {
      id: self.id,
      project: {
        id: self.project.try(:id),
        name: self.project.try(:name),
        color: self.project.try(:color)
      },
      billable: {
        id: 'billable',
        name: 'Billable'
      },
      description: self.description,
      from: self.started_at.try(:strftime, "%H:%M"),
      to: self.ended_at.try(:strftime, "%H:%M"),
      duration: self.ended_at.present? ? self.duration : (Time.now - self.started_at).round,
      tag: {
        id: self.time_category.try(:id),
        name: self.time_category.try(:name)
      },
      date: self.format_date
    }
  end

  def format_date
    DAYS[self.started_at.strftime("%w").to_i] + self.started_at.strftime(", %d %b")
  end

  private

  def set_duration
    if self.started_at.present? && self.ended_at.present?
      self.duration = (self.ended_at - self.started_at).round
    else
      self.duration = 0
    end
  end

end
