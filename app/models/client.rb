class Client < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :conversations, -> { visible }
  has_many :messages, -> { where(sender_type: Client.name) }, through: :conversations
  has_noticed_notifications
end
