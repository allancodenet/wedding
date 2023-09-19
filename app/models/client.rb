class Client < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :phone_number, presence: true
  validate :validate_phone_number_length
  has_many :conversations
  has_many :likes
  has_many :ratings, as: :rater
  has_noticed_notifications

  def validate_phone_number_length
    unless phone_number.to_s.length == 12
      errors.add(:phone_number, "must be exactly 10 characters long")
    end
  end
end
