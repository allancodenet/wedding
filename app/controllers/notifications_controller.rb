class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = current_user.notifications.newest_first.unread
    @previous_notifications = current_user.notifications.newest_first.read
  end

  def show
    notification = current_user.notifications.find(params[:id])
    notification.mark_as_read!

    if (url = notification.to_notification.url)
      redirect_to url
    else
      redirect_to notifications_path, notice: "read notification"
    end
  end

  def read_all
    current_user.notifications.mark_as_read!
    redirect_to notifications_path, notice: "Marked all as read"
  end
end
