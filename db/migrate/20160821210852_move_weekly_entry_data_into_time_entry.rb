class MoveWeeklyEntryDataIntoTimeEntry < ActiveRecord::Migration
  def up
    WeeklyEntry.all.each do |we|
      [
         ["communication", "Management"],
         ["development", "Development"],
         ["bugs", "bug"],
         ["code_review", "code review"],
         ["qa", "QA"],
         ["infraestructure", "Infrastructure"],
         ["uxui", "UX"]
      ].each do |old_category_name|
         time_category = TimeCategory.where("name LIKE ? ", "%#{old_category_name[1]}%").first
         raise old_category_name.inspect if time_category == nil

         TimeEntry.create(
           user_id: we.user_id,
           project_id: we.project_id,
           description: "Weekly Entry",
           time_category_id: time_category.id,
           started_at: we.week.to_datetime,
           ended_at: we.week.to_datetime + we.send(old_category_name[0]).hours
         )
       end
    end

    # This table is not used anymore
    drop_table :weekly_entries

    add_column :time_categories, :hex_color, :string, default: "#7f7fff"

    colors = ["#7f7fff", "#7fff7f", "#ff7f7f", "#7F7F7F", "#ffff7f", "#ffbf7f", "#bf7fff"]
    TimeCategory.all.each_with_index do |tc, index|
      tc.hex_color = colors[index]
      tc.save
    end

  end
end
