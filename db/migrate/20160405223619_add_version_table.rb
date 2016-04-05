class AddVersionTable < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :name
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
