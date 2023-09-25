class RemoveAverageRatingFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :average_rating, :decimal, precision: 2
    add_column :providers, :average_rating, :decimal, precision: 4, scale: 2
  end
end
