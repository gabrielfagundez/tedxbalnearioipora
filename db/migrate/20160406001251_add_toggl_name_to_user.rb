class AddTogglNameToUser < ActiveRecord::Migration
  def change
    add_column :team_members, :toggl_name, :string
  end
end
