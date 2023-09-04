class Conversation < ApplicationRecord
  has_noticed_notifications
  belongs_to :client
  belongs_to :provider
  belongs_to :user_with_unread_messages, class_name: :User, inverse_of: :unread_conversations, optional: true
  has_many :messages, -> { order(:created_at) }, dependent: :destroy
  validates :provider_id, uniqueness: {scope: :client_id}

  def deleted_client_or_provider?
    provider.nil? || client.nil?
  end

  def other_recipient(user)
    (client == user.client) ? provider : client
  end

  def client?(user)
    client == user.client
  end

  def provider?(user)
    provider == user.providers
  end

  def latest_message_read_by_other_recipient?(user)
    return false unless latest_message

    other_user = other_recipient(user).user

    notification = latest_message.latest_notification_for_recipient(other_user)
    notification&.read?
  end

  def latest_message
    messages.reorder(created_at: :desc).first
  end

  def mark_notifications_as_read(user)
    notifications_as_conversation.where(recipient: user).unread.mark_as_read!
    update(user_with_unread_messages: nil) if unread_messages_for?(user)
  end

  def unread_messages_for?(user)
    user_with_unread_messages == user
  end

  def first_reply?(provider)
    messages.where(sender: provider).one? && latest_message.sender == provider
  end

  def provider_replied?
    messages.from_provider.any?
  end
end
