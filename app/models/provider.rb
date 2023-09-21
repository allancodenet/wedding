class Provider < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  has_many :likes, as: :record, dependent: :destroy
  has_many :ratings, as: :record, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :conversations
  has_many :messages, -> { where(sender_type: Provider.name) }, through: :conversations

  has_noticed_notifications
  validates :service, :name, :description, :location, presence: true
  validates :images, presence: true
  validate :validate_attachments_limit, :validate_attachment_formats
  # validate :validate_phone_number_length
  enum service: {
    venue: 0,
    photographer: 1,
    caterer: 2,
    decorator: 3,
    makeup: 4,
    MC: 5,
    sound: 6,
    barber: 7,
    videography: 8,
    gowns: 9,
    shoes: 10,
    rings: 11,
    maids_outfit: 12,
    grooms_outfit: 13

  }

  def liked_by?(client)
    likes.where(client: client).any?
  end

  def like(client)
    likes.where(client: client).first_or_create
  end

  def unlike(client)
    likes.where(client: client).destroy_all
  end

  def rated_by?(rater)
    ratings.where(rater: rater).any?
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[service location name service_enum likes_count average_ratings]
  end

  def self.ransackable_associations(auth_object = nil)
    ["likes", "ratings", "user"]
  end

  ransacker :service_enum, formatter: proc { |v| services[v] } do |parent|
    parent.table[:service]
  end
  # ransacker :service, formatter: proc { |v| services[v] }

  def validate_attachments_limit
    if images.length > 5
      errors.add(:images, "can't exceed 5 files")
    end
  end

  def validate_attachment_formats
    allowed_formats = ["image/jpeg", "image/png", "image/jpg"]

    images.each do |image|
      unless allowed_formats.include?(image.content_type)
        errors.add(:images, "only JPEG and PNG formats are allowed")
      end
    end
  end

  def validate_phone_number_length
    unless phone_number.to_s.length == 12
      errors.add(:phone_number, "must be exactly 12 characters long")
    end
  end

  def resized_images
    images.map { |image| image.variant(resize_to_limit: [300, 200]) }
  end

  def show_images
    images.map { |image| image.variant(resize_to_limit: [1400, 800]) }
  end
end
