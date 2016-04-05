class AddScrumInfoToProject < ActiveRecord::Migration
  def change
    add_column :projects, :daily_meeting, :string
    add_column :projects, :retrospectives, :string
    add_column :projects, :iteration_planning, :string
    add_column :projects, :estimates_model, :string
    add_column :projects, :issue_tracker, :string
  end
end
