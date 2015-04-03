class AddUpvotesCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :upvotes_count, :integer
  end
end
