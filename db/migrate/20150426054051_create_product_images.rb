class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer :product_variation_id
      t.text :filepath

      t.timestamps
    end
    add_index :product_images, :product_variation_id
  end
end
