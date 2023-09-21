class AddCommentToRatings < ActiveRecord::Migration[7.0]
  def change
    add_column :ratings, :comment, :text
  end
end
