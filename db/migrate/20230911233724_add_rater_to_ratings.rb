class AddRaterToRatings < ActiveRecord::Migration[7.0]
  def change
    add_reference :ratings, :rater, polymorphic: true, null: false
  end
end
