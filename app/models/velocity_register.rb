class VelocityRegister < ActiveRecord::Base

  before_save :set_end_date

  belongs_to :project
  belongs_to :version

  private

  def set_end_date
    self.end_date = self.start_date + self.project.velocity_frequency_in_days.days
  end

end
