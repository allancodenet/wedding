class MessagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @message = Message.new
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params.merge(conversation:, sender:))
    # authorize @message

    if @message.save_and_notify
      respond_to do |format|
        format.turbo_stream { @new_message = conversation.messages.build }
        format.html { redirect_to conversation }
      end
    else
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def conversation
    @conversation ||= Conversation.find(params[:conversation_id])
  end

  def provider
    conversation.provider
  end

  def sender
    if conversation.client?(current_user)
      current_user.client
    elsif conversation.provider?(current_user)
      current_user.provider
    end
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content)
  end
end
