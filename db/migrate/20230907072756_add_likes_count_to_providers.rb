class AddLikesCountToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :likes_count, :integer, default: 0
  end
end
