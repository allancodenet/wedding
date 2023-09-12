class Client < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :conversations
  has_many :likes
  has_many :ratings, as: :rater
  has_noticed_notifications
end
