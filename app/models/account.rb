class Account < ActiveRecord::Base

  has_many :users
  has_many :time_categories
  has_many :clients

  def users_count
    self.users.length
  end

  def last_week_hours
    # TODO: retrieve real data
    0
  end

end
