class Message < ApplicationRecord
  belongs_to :conversation, touch: true
  belongs_to :sender, polymorphic: true, touch: true
  has_one :client, through: :conversation
  has_one :provider, through: :conversation

  has_noticed_notifications
  validates :content, presence: true
end
