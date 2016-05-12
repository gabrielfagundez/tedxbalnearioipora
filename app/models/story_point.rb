class StoryPoint < ActiveRecord::Base

  default_scope { order('value ASC') }

  belongs_to :project

end
