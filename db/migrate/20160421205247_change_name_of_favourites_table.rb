class ChangeNameOfFavouritesTable < ActiveRecord::Migration
  def change
    rename_table :favourite_projects, :favorite_projects
  end
end
