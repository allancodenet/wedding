class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_many :providers, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_one :client, dependent: :destroy
  validates :role, presence: true, unless: :admin?
  has_many :conversations, ->(user) {
    unscope(where: :user_id)
      .left_joins(:provider, :client)
      .where("providers.user_id = ? OR clients.user_id = ?", user.id, user.id)
  }
  scope :admin, -> { where(admin: true) }
  has_many :unread_conversations,
    class_name: :Conversation,
    foreign_key: :user_with_unread_messages_id,
    inverse_of: :user_with_unread_messages

  enum role: {
    client: 0,
    provider: 1
  }
end
