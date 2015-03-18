class CreateCategoriesProducts < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :product_id
      t.integer :category_id


      t.timestamps
    end
    add_index :categories_products, :category_id
    add_index :categories_products, :product_id
  end
end
