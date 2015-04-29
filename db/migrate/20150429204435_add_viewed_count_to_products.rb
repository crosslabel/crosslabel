class AddViewedCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :viewed_count, :integer
  end
end
