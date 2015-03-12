class AddProfilePictureAndNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :profile_picture, :string
    add_column :users, :name, :string
  end
end
