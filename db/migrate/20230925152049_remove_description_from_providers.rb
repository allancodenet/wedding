class RemoveDescriptionFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :description, :text
  end
end
