class TimeCategory < ActiveRecord::Base

  belongs_to :account

  def rgba_color(transparency = 1)
    "rgba(#{self.hex_color[1..2].hex}, #{self.hex_color[3..4].hex}, #{self.hex_color[5..6].hex}, #{transparency})"
  end

end
