class Client < ActiveRecord::Base

  has_many :projects
  has_and_belongs_to_many :users

  def self.load_seeds
    Client.create(name: 'Numerex')
    Client.create(name: 'YouScience')
    Client.create(name: 'S. Emmons')
  end

end
