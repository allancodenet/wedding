class AddPublishedAtToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :published_at, :datetime
  end
end
