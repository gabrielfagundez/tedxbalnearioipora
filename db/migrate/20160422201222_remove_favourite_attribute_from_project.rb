class RemoveFavouriteAttributeFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :favourite, :boolean
  end
end
