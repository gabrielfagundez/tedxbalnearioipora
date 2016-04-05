class AddHiredHoursToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :hired_hours, :integer
  end
end
