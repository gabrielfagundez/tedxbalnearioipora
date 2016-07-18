class CreateWeeklyTimeEntries < ActiveRecord::Migration
  def change
    # create_table :weekly_time_entries do |t|
    #
    #   # Identifiers
    #   t.integer :user_id
    #   t.integer :project_id
    #   t.integer :time_category_id
    #   t.string  :week
    #
    #   # Value
    #   t.decimal :value
    #
    #   # Metadata
    #   t.timestamps null: false
    # end
    #
    # WeeklyEntry.all.each do |we|
    #   [
    #      ["communication", "communication"],
    #      ["development", "development"],
    #      ["bugs", "bug"],
    #      ["code_review", "code_review"],
    #      ["qa", "qa"],
    #      ["infraestructure", "infrastructure"],
    #      ["uxui", "ux"]
    #   ].each do |old_category_name|
    #      time_category = TimeCategory.where("name LIKE ? ", "%#{old_category_name[1]}%").first
    #      WeeklyTimeEntry.create(
    #        user_id: we.user_id,
    #        project_id: we.project_id,
    #        time_category_id: time_category.id,
    #        week: we.week,
    #        value: we.send(old_category_name[0])
    #      )
    #    end
    # end
  end
end
