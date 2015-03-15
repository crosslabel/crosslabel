class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :telelphone
      t.string :country
      t.string :profile_image
      t.datetime :birth_date

      t.timestamps
    end
    add_index :profiles, :user_id
    add_index :profiles, :username
  end
end
