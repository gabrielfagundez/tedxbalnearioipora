class CreateUserWidget < ActiveRecord::Migration
  def change
    create_table :widgets do |t|
      t.integer :user_id
      t.integer :project_id
      t.string :widget_type

      t.timestamps null: false
    end
  end
end
