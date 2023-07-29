class CreateProviders < ActiveRecord::Migration[7.0]
  def change
    create_table :providers do |t|
      t.integer :service
      t.string :name
      t.text :description
      t.string :website
      t.string :instagram
      t.string :tiktok
      t.string :user
      t.string :location

      t.timestamps
    end
  end
end
