class MessagePolicy < ApplicationPolicy
  # def create?
  #   if provider_sender?
  #     true
  #   elsif client_sender?
  #     user.permissions.can_message_provider?(role_type: provider.role_type)
  #   end
  # end

  # private

  # def provider_sender?
  #   user.provider == provider
  # end

  # def client_sender?
  #   user.client == client
  # end

  # def client
  #   record.conversation.client
  # end

  # def provider
  #   record.conversation.provider
  # end
end
