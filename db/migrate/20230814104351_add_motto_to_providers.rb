class AddMottoToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :motto, :text
  end
end
