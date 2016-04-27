class MigrateTeamMembersToUsers < ActiveRecord::Migration
  def change
    add_column :weekly_entries, :user_id, :integer

    WeeklyEntry.all.each do |we|
      if we.team_member_id == 1
        we.user_id = 1
      elsif we.team_member_id == 2
        we.user_id = 12
        we.save
      elsif we.team_member_id == 3
        we.user_id = 13
        we.save
      elsif we.team_member_id == 4
        we.user_id = 13
        we.save
      elsif we.team_member_id == 5
        we.user_id = 2
        we.save
      elsif we.team_member_id == 6
        we.user_id = 9
        we.save
      elsif we.team_member_id == 7
        we.user_id = 11
        we.save
      elsif we.team_member_id == 8
        we.user_id = 10
        we.save
      elsif we.team_member_id == 9
        we.user_id = 8
        we.save
      elsif we.team_member_id == 10
        we.user_id = 15
        we.save
      elsif we.team_member_id == 11
        we.user_id = 16
        we.save
      elsif we.team_member_id == 12
        we.user_id = 4
        we.save
      elsif we.team_member_id == 13
        we.user_id = 17
        we.save
      elsif we.team_member_id == 14
        we.user_id = 18
        we.save
      elsif we.team_member_id == 15
        we.user_id = 19
        we.save
      elsif we.team_member_id == 16
        we.user_id = 20
        we.save
      elsif we.team_member_id == 17
        we.user_id = 7
        we.save
      elsif we.team_member_id == 18
        we.user_id = 21
        we.save
      elsif we.team_member_id == 19
        we.user_id = 22
        we.save
      elsif we.team_member_id == 20
        we.user_id = 23
        we.save
      end
    end
  end
end
