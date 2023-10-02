class Client < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  # validates :phone_number, presence: true
  # validate :validate_phone_number_length
  has_many :conversations, dependent: :destroy
  has_many :likes, as: :liker, dependent: :destroy
  has_many :ratings, as: :rater, dependent: :destroy
  has_noticed_notifications

  def validate_phone_number_length
    unless phone_number.to_s.length >= 12
      errors.add(:phone_number, "Check phone number")
    end
  end
end
