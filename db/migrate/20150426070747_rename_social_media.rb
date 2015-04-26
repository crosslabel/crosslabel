class RenameSocialMedia < ActiveRecord::Migration
  def change
    rename_table :social_media, :social_medias
  end
end
