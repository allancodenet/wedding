class CreateRatings < ActiveRecord::Migration[7.0]
  def change
    create_table :ratings do |t|
      t.integer :star
      t.references :user, null: false, foreign_key: true
      t.belongs_to :record, polymorphic: true, null: false

      t.timestamps
    end
  end
end
