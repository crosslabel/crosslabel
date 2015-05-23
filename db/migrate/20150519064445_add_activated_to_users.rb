class AddActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean, default: false
    add_index :users, :activated
  end
end
