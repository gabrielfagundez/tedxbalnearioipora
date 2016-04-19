class AddTimeEntryModel < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :time_categories do |t|
      t.integer :account_id
      t.string :name
      t.timestamps null: false
    end

    create_table :time_entries do |t|
      t.integer :user_id
      t.integer :project_id

      t.string :description
      t.integer :time_category_id
      t.boolean :billable
      t.datetime :started_at
      t.datetime :ended_at
      t.integer :duration

      t.timestamps null: false
    end
  end
end
