class Conversation < ApplicationRecord
  has_noticed_notifications
  belongs_to :client
  belongs_to :provider
  has_many :messages, -> { order(:created_at) }, dependent: :destroy
end
