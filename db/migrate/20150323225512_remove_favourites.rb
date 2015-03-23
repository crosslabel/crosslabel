class RemoveFavourites < ActiveRecord::Migration
  def change
    drop_table :favourites
  end
end
