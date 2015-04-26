class CreateVariationSizes < ActiveRecord::Migration
  def change
    create_table :variation_sizes do |t|
      t.integer :product_variation_id
      t.string :size

      t.timestamps
    end
  end
end
