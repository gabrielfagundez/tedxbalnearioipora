class UserEvent < ActiveRecord::Base

  belongs_to :user

  EVENT_TYPE = {
    milestone: 'vacation'
  }

end
