# To deliver this notification:
#
# LikeNotification.with(provider: @provider).deliver(@provider)
# LikeNotification.with(post: @post).deliver(current_user)

class LikeNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #

  # Define helper methods to make rendering easier.
  #
  def provider
    params[:message].record_id
  end

  def title
    "Your post was liked"
  end

  def url
    provider_path(provider)
  end
end
