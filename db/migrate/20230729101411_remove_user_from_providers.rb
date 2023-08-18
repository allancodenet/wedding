class RemoveUserFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :user, :string
  end
end
