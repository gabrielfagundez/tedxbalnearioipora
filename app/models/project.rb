class Project < ActiveRecord::Base

  has_many :weekly_entries

  def self.load_seeds
    numerex = Client.where(name: 'Numerex').first
    youscience = Client.where(name: 'YouScience').first
    semmons = Client.where(name: 'S. Emmons').first

    Project.create(client_id: numerex.id, name: 'RSC')
    Project.create(client_id: numerex.id, name: 'FastTrackFleet')
    Project.create(client_id: numerex.id, name: 'iManage')
    Project.create(client_id: numerex.id, name: 'iTank')

    Project.create(client_id: youscience.id, name: 'Web App')

    Project.create(client_id: semmons.id, name: 'YoYoBlox')
    Project.create(client_id: semmons.id, name: 'Studio Movie Grill')
  end

  def stats
    {
      three_weeks_ago: self.weekly_entries.where(week: (Date.today.beginning_of_week(:monday) - 3.week).to_s),
      two_weeks_ago: self.weekly_entries.where(week: (Date.today.beginning_of_week(:monday) - 2.week).to_s),
      one_week_ago: self.weekly_entries.where(week: (Date.today.beginning_of_week(:monday) - 1.week).to_s),
      this_week: self.weekly_entries.where(week: Date.today.beginning_of_week(:monday).to_s)
    }
  end

end
