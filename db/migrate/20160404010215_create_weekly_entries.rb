class CreateWeeklyEntries < ActiveRecord::Migration
  def change
    create_table :weekly_entries do |t|
      t.integer :team_member_id
      t.integer :project_id
      t.string :week

      t.decimal :communication
      t.decimal :development
      t.decimal :bugs
      t.decimal :code_review
      t.decimal :qa
      t.decimal :infraestructure
      t.decimal :uxui

      t.timestamps null: false
    end
  end
end
