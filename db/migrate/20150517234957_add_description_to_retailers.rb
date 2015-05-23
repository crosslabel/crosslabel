class AddDescriptionToRetailers < ActiveRecord::Migration
  def change
    add_column :retailers, :description, :text
  end
end
