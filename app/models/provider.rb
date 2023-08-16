class Provider < ApplicationRecord
  belongs_to :user
  has_many_attached :images, dependent: :destroy
  validates :service, :name, :description, :location, presence: true
  validates :images, presence: true
  validate :validate_attachments_limit, :validate_attachment_formats

  enum service: {
    venue: 0,
    photographer: 1,
    caterer: 2,
    decorator: 3,
    makeup: 4,
    MC: 5,
    sound: 6
  }
  def validate_attachments_limit
    if images.length > 5
      errors.add(:images, "can't exceed 5 files")
    elsif images.length < 5
      errors.add(:images, "can't be less than 5 files")
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

  def resized_images
    images.map { |image| image.variant(resize_to_limit: [300, 300]) }
  end

  def show_images
    images.map { |image| image.variant(resize_to_limit: [1400, 800]).processed }
  end
end
