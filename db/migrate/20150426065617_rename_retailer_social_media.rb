class RenameRetailerSocialMedia < ActiveRecord::Migration
  def change
    rename_table :retailer_social_media, :retailers_social_medias
  end
end
