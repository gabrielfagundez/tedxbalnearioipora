class AddTeamLeaderToUser < ActiveRecord::Migration
  def change
    add_column :users, :team_leader_id, :integer
  end
end
