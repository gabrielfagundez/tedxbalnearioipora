class Version < ActiveRecord::Base

  belongs_to :project
  has_many :velocity_registers

end
