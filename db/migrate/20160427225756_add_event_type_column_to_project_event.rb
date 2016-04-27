class AddEventTypeColumnToProjectEvent < ActiveRecord::Migration
  def change
    add_column :project_events, :event_type, :string
  end
end
