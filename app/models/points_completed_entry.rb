class PointsCompletedEntry < ActiveRecord::Base

  belongs_to :project
  belongs_to :version

  def self.load_seeds
    PointsCompletedEntry.create(project_id: 17, points_completed: 12, period: "#{(Date.today.beginning_of_week(:monday) - 10.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 9.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 13, period: "#{(Date.today.beginning_of_week(:monday) -  9.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 8.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 10, period: "#{(Date.today.beginning_of_week(:monday) -  8.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 7.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 5, period: "#{(Date.today.beginning_of_week(:monday) -   7.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 6.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 2, period: "#{(Date.today.beginning_of_week(:monday) -   6.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 5.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 17, period: "#{(Date.today.beginning_of_week(:monday) -  5.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 4.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 22, period: "#{(Date.today.beginning_of_week(:monday) -  4.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 3.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 20, period: "#{(Date.today.beginning_of_week(:monday) -  3.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 2.week).strftime("%m-%d").to_s}")
    PointsCompletedEntry.create(project_id: 17, points_completed: 19, period: "#{(Date.today.beginning_of_week(:monday) -  2.week).strftime("%m-%d").to_s} - #{(Date.today.beginning_of_week(:monday) - 1.week).strftime("%m-%d").to_s}")
  end

end
