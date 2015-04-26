class CreateVariationStocks < ActiveRecord::Migration
  def change
    create_table :variation_stocks do |t|
      t.integer :product_variation_id
      t.integer :min
      t.integer :max
      t.boolean :has_more

      t.timestamps
    end
    add_index :variation_stocks, :product_variation_id
  end
end
