class Client < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  has_many :conversations
  has_noticed_notifications
end
