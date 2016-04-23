class CreateUserEventTable < ActiveRecord::Migration
  def change
    create_table :user_events do |t|
      t.string :name
      t.text :description
      t.string :event_type
      t.datetime :start_date
      t.datetime :end_date

      t.integer :user_id

      t.timestamps null: false
    end
  end
end
