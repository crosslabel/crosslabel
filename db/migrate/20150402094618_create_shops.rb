class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :name
      t.text :description
      t.string :website
      t.string :twitter_url
      t.string :facebook_url

      t.timestamps
    end
  end
end
