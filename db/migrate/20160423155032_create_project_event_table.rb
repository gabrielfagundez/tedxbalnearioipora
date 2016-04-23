class CreateProjectEventTable < ActiveRecord::Migration
  def change
    create_table :project_events do |t|
      t.string :name
      t.text :description
      t.string :event_type
      t.datetime :expected_date

      t.integer :project_id

      t.timestamps null: false
    end
  end
end
