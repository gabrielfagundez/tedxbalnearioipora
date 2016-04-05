class AddPointsRegistryTable < ActiveRecord::Migration
  def change
    create_table :points_completed_entries do |t|
      t.string :period
      t.integer :points_completed
      t.integer :project_id
      t.integer :version_id

      t.timestamps null: false
    end
  end
end
