class ColdMessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_client!
  before_action :require_new_conversation!

  def new
    message = Message.new(conversation:)
    @cold_message = cold_message(message)
  end

  def create
    message = Message.new(message_params.merge(conversation:, sender: client))
    if message.save_and_notify(cold_message: true)
      redirect_to message.conversation
    else
      @cold_message = cold_message(message)
      render :new, status: :unprocessable_entity
    end
  end

  private

  def cold_message(message)
    ColdMessage.new(message:)
  end

  def require_client!
    unless client.present?
      flash[:warning] = "Must be a client to initiate a conversation"
      redirect_to providers_path, warning:
    end
  end

  def require_new_conversation!
    redirect_to conversation unless conversation.new_record?
  end

  def conversation
    @conversation ||= Conversation.find_or_initialize_by(client:, provider:)
  end

  def provider
    @provider ||= Provider.find(params[:provider_id])
  end

  def client
    @client = current_user.client
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
