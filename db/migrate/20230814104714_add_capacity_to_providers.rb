class AddCapacityToProviders < ActiveRecord::Migration[7.0]
  def change
    add_column :providers, :capacity, :int4range
  end
end
