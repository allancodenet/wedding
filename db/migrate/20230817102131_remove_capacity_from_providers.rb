class RemoveCapacityFromProviders < ActiveRecord::Migration[7.0]
  def change
    remove_column :providers, :capacity, :int4range
  end
end
