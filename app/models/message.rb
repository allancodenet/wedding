class Message < ApplicationRecord
  include Messages::Notifications
  belongs_to :conversation, touch: true
  belongs_to :sender, polymorphic: true, touch: true
  has_one :client, through: :conversation
  has_one :provider, through: :conversation

  has_noticed_notifications
  validates :content, presence: true
  after_create_commit :cache_conversation_read_status
  after_create_commit :broadcast_message
  scope :from_provider, -> { where(sender_type: Provider.name) }

  def broadcast_message
    # Broadcast the Turbo Stream for appending the new message to the "messages" container
    broadcast_append_to("messages", target: "messages") do
      render partial: "messages/message", locals: {message: self}
    end

    # Broadcast the Turbo Stream for updating the "new_message" element
    broadcast_update_to("new_message", target: "new_message") do
      render "conversations/new_message", conversation: conversation, message: self
    end
  end

  def cache_conversation_read_status
    conversation.update!(user_with_unread_messages: recipient&.user)
  end

  def self.first_message?(provider)
    joins(:conversation).where(conversation: {provider:}).one?
  end

  def deleted_sender?
    sender.nil?
  end

  def sender?(user)
    user_client = user.client
    user_providers = user.providers

    # Check if the sender matches the user's client or is one of the providers
    [user_client, user_providers.find { |provider| provider == sender }].include?(sender)
  end

  def recipient
    if sender == provider
      client
    elsif sender == client
      provider
    end
  end

  def latest_notification_for_recipient(recipient)
    notifications_as_message.where(recipient:).last
  end
end
