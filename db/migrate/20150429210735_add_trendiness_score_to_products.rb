class AddTrendinessScoreToProducts < ActiveRecord::Migration
  def change
    add_column :products, :trendiness_score, :float
  end
end
