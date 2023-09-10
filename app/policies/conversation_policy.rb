class ConversationPolicy < ApplicationPolicy
  def create?
    show?
  end

  def show?
    involved_in_conversation?
  end

  private

  def involved_in_conversation?
    client_recipient? || provider_recipient?
  end

  def client_recipient?
    user.client == record.client
  end

  def provider_recipient?
    user.providers == record.provider
  end
end
