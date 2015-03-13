class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image
      t.string :link
      t.string :unit_price
      t.string :sale_price
      t.integer :retailer_id
      t.boolean :archived, default: false

      t.timestamps
    end

    add_index :products, :retailer_id
  end
end
