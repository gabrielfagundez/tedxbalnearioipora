class PointsCompletedEntry < ActiveRecord::Base

  belongs_to :project
  belongs_to :version

end
