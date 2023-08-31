ColdMessage = Struct.new(:message) do
  def client
    message.conversation.client
  end

  def provider
    message.conversation.provider
  end
end
