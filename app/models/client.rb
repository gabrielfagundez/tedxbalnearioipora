class Client < ActiveRecord::Base

  has_many :projects
  belongs_to :account
  has_and_belongs_to_many :users

end
