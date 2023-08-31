class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_provider!

  def new
    @message = Message.new
  end

  # POST /messages or /messages.json
  def create
    # @conversation = Conversation.find(params[:conversation_id])
    @message = Message.new(message_params)
    # @message.sender = current_user

    respond_to do |format|
      if @message.save
        format.html { redirect_to root_url(@message), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def conversation
    @conversation ||= Conversation.find_or_initialize_by(client:, provider:)
  end

  def set_provider!
    @provider ||= Provider.find(params[:provider_id])
  end

  def provider
    @provider ||= Provider.find(params[:provider_id])
  end

  def client
    @client = current_user.client
  end

  # Only allow a list of trusted parameters through.
  def message_params
    params.require(:message).permit(:content, :sender_type, :sender_id)
  end
end
