class ChangeRatingCountFromProviders < ActiveRecord::Migration[7.0]
  def change
    rename_column :providers, :rating_count, :ratings_count
  end
end
