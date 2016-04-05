class AddTeamLeaderToUser < ActiveRecord::Migration
  def change
    add_column :projects, :team_leader_id, :integer
  end
end
