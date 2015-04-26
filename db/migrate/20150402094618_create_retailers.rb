class CreateRetailers < ActiveRecord::Migration
  def change
    create_table :retailers do |t|
      t.string :name
      t.text :homepage_link
      t.integer :city_id

      t.timestamps
    end
    add_index :retailers, :city_id
  end
end
