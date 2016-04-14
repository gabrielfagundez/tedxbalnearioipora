class AddTeamMemberAsignmentTable < ActiveRecord::Migration
  def change
    create_table :projects_team_members do |t|
      t.integer :project_id
      t.integer :team_member_id
    end
  end
end
