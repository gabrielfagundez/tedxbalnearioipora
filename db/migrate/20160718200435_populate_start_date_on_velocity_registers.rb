class PopulateStartDateOnVelocityRegisters < ActiveRecord::Migration
  def up
    VelocityRegister.all.each do |vr|
      vr.start_date = vr.created_at
      vr.end_date = vr.created_at + vr.project.velocity_frequency_in_days.days
      vr.save!
    end
  end
end
