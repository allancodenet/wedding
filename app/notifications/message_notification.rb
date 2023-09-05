# To deliver this notification:
#
# MessageNotification.with(post: @post).deliver_later(current_user)
# MessageNotification.with(post: @post).deliver(current_user)

class MessageNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  param :message
  param :conversation

  # Define helper methods to make rendering easier.
  #
  def title
    " Message from #{message.sender.name}"
  end

  def url
    conversation_path(conversation)
  end

  def message
    params[:message]
  end

  def conversation
    params[:conversation]
  end
end
