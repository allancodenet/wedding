class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations.includes(:messages)
  end

  def show
    @new_message = Message.new(conversation: @conversation)
  end
end
