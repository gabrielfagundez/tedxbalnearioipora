class Project < ActiveRecord::Base

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

end
