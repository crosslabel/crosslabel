class CreateUpvotes < ActiveRecord::Migration
  def change
    create_table :upvotes do |t|
      t.references :upvotable, index: true, :polymorphic => true
      t.references :user, index: true

      t.timestamps
    end
  end
end
