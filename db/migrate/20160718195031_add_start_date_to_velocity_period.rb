class AddStartDateToVelocityPeriod < ActiveRecord::Migration
  def change
    rename_table :points_completed_entries, :velocity_registers
    add_column :velocity_registers, :start_date, :datetime
    add_column :velocity_registers, :end_date, :datetime
    rename_column :velocity_registers, :points_completed, :points
  end
end
