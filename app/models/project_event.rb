class ProjectEvent < ActiveRecord::Base

  belongs_to :project

  EVENT_TYPE = {
    milestone: 'milestone'
  }

end
