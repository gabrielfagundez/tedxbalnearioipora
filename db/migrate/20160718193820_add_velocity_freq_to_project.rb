class AddVelocityFreqToProject < ActiveRecord::Migration
  def change
    add_column :projects, :velocity_frequency_in_days, :integer, default: 7
  end
end
