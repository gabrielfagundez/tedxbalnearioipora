class CleanupUnusedTables < ActiveRecord::Migration

  def up
    drop_table :project_events
    drop_table :user_events
    drop_table :story_points
    drop_table :widgets
    drop_table :versions
    drop_table :team_members
    drop_table :projects_team_members

    remove_column :velocity_registers, :version_id
    remove_column :projects, :hired_hours
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end

end
