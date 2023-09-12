class Rating < ApplicationRecord
  belongs_to :record, polymorphic: true, counter_cache: true
  belongs_to :rater, polymorphic: true
  after_commit :update_average_rating, on: [:create, :update]
  validates :record_id, uniqueness: {scope: :rater_id}

  def update_average_rating
    record.update!(average_rating: record.ratings.average(:star))
  end
end
