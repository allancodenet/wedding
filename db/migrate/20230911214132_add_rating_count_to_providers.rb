class AddRatingCountToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :rating_count, :integer, default: 0
    add_column :providers, :average_rating, :decimal, precision: 2
  end
end
