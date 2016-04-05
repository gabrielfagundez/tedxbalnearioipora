class AddFavouriteProjects < ActiveRecord::Migration
  def change
    add_column :projects, :favourite, :boolean
  end
end
