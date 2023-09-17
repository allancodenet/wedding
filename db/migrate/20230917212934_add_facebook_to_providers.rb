class AddFacebookToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :facebook, :string
  end
end
