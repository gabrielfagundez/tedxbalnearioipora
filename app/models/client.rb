class Client < ActiveRecord::Base

  has_many :projects

  def self.load_seeds
    Client.create(name: 'Numerex')
    Client.create(name: 'YouScience')
    Client.create(name: 'S. Emmons')
  end

end
