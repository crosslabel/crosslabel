class CreateHumanDemographicsCategories < ActiveRecord::Migration
  def change
    create_table :human_demographics_categories do |t|
      t.integer :product_variation_id
      t.integer :category_id

      t.timestamps
    end
    add_index :human_demographics_categories, :product_variation_id
    add_index :human_demographics_categories, :category_id
  end
end
