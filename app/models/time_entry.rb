class TimeEntry < ActiveRecord::Base

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
      project: self.project.name,
      description: self.description,
      from: self.started_at.try(:strftime, "%H:%M"),
      to: self.ended_at.try(:strftime, "%H:%M") || "",
      duration: self.duration  || "",
      tag: self.time_category.name
    }
  end

end
