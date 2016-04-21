class TimeEntry < ActiveRecord::Base

  DAYS = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

  belongs_to :project
  belongs_to :user
  belongs_to :time_category

  def self.closed
    where.not(ended_at: nil)
  end

  def self.by_started_at
    order("started_at DESC")
  end

  def pretty_data
    {
      id: self.id,
      project: self.project.name,
      description: self.description,
      from: self.started_at.try(:strftime, "%H:%M"),
      to: self.ended_at.try(:strftime, "%H:%M") || "",
      duration: self.duration  || 0,
      tag: self.time_category.name,
      date: self.format_date
    }
  end

  def format_date
    DAYS[self.started_at.strftime("%w").to_i] + self.started_at.strftime(", %d %b")
  end

end
