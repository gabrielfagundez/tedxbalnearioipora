class Client < ActiveRecord::Base

  has_many :projects
  belongs_to :account
  has_and_belongs_to_many :users

  def hours_last_week
    "TBD"
  end

  def people_involved_last_week
    "TBD"
  end

end
