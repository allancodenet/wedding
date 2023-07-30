class CreateClients < ActiveRecord::Migration[7.0]
  def change
    create_table :clients do |t|
      t.string :name
      t.date :wedding_date
      t.string :location
      t.integer :guest_no
      t.integer :budget

      t.timestamps
    end
  end
end
