class CreateStoryPointDefinitions < ActiveRecord::Migration
  def change
    create_table :story_points do |t|
      t.string :value
      t.text :definition
      t.integer :project_id
    end
  end
end
