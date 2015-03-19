class AddTypeToProducts < ActiveRecord::Migration
  def change
    add_column :products, :for_men, :boolean, :default => false
    add_index :products, :for_men
  end
end
