class AddExpectedHoursToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :expected_hours, :integer
  end
end
