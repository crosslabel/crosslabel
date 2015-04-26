class CreateRetailerSocialMedia < ActiveRecord::Migration
  def change
    create_table :retailer_social_media do |t|
      t.integer :social_media_id
      t.integer :retailer_id
      t.text :social_media_link

      t.timestamps
    end
    add_index :retailer_social_media, :retailer_id
  end
end
