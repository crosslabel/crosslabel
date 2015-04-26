class CreateHumanDemographics < ActiveRecord::Migration
  def change
    create_table :human_demographics do |t|
      t.string :name

      t.timestamps
    end
  end
end
