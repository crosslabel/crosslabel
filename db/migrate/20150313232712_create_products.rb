class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.text :homepage_product_link
      t.float :original_price
      t.float :sale_price
      t.integer :retailer_id
      t.string :origin_id
      t.integer :category_id
      t.boolean :active, default: true

      t.timestamps
    end

    add_index :products, :retailer_id
  end
end
