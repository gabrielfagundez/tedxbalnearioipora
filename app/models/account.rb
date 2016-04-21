class Account < ActiveRecord::Base

  has_many :users
  has_many :time_categories
  has_many :clients

end
