class Provider < ApplicationRecord
  has_rich_text :description
  belongs_to :user
  validates :phone_number, presence: true
  # validate :validate_phone_number_length
  has_many_attached :images, dependent: :destroy
  has_many :likes, as: :record, dependent: :destroy
  has_many :ratings, as: :record, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :conversations
  has_many :messages, -> { where(sender_type: Provider.name) }, through: :conversations
  has_noticed_notifications
  validates :service, :name, :location, presence: true
  # validates :service, uniqueness: {scope: :user_id}
  validates :images, presence: true
  validate :validate_attachments_limit
  # validate :validate_phone_number_length
  enum service: {
    "🏛️ Venue": 0,
    "📸 Photographer": 1,
    "🍽️ Caterer": 2,
    "🎨 Decorator": 3,
    "💄 Beauty": 4,
    "🎤 MC": 5,
    "🔊 Sound": 6,
    "💈 Barber": 7,
    "🎥 Videography": 8,
    "👗 Gowns": 9,
    "👠 Shoes": 10,
    "💍 Rings": 11,
    "👰 Maids Outfit": 12,
    "🤵 Grooms Outfit": 13,
    "🚗 Car Hire": 14,
    "💌 Wedding Cards": 15,
    "🔒 Security": 16
  }
  scope :draft, -> { where(published_at: nil) }
  scope :scheduled, -> { where("published_at >?", Time.current) }
  scope :published, -> { where("published_at <=?", Time.current) }
  scope :published_newest_first, -> { published.order(published_at: :desc) }

  def draft?
    published_at.nil?
  end

  def published?
    published_at? && published_at <= Time.current
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def top_rated?
    average_rating.to_i > 4
  end

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
    %w[service location name service_enum likes_count average_rating]
  end

  def self.ransackable_associations(auth_object = nil)
    ["likes", "ratings", "user"]
  end

  ransacker :service_enum, formatter: proc { |v| services[v] } do |parent|
    parent.table[:service]
  end
  # ransacker :service, formatter: proc { |v| services[v] }

  def validate_attachments_limit
    if images.length > 10
      errors.add(:images, "can't exceed 10 files")
    end
  end

  def validate_phone_number_length
    unless phone_number.to_s.length >= 9
      errors.add(:phone_number, "check phone number length")
    end
  end

  def resized_images
    images.map { |image| image.variant(resize_to_limit: [720, 480], saver: {strip: true, quality: 80, interlace: true, optimize_coding: true, trellis_quant: true, quant_table: 3}, format: "jpg") }
  end

  # def show_images
  #   images.map { |image| image.variant(resize_to_limit: [1400, 800], saver: {strip: true, quality: 80, interlace: true, optimize_coding: true, trellis_quant: true, quant_table: 3}, format: "jpg") }
  # end
end
