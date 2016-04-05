class Version < ActiveRecord::Base

  belongs_to :project
  has_many :points_completed_entries

end
