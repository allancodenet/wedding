class Like < ApplicationRecord
  belongs_to :client
  belongs_to :record, polymorphic: true, counter_cache: true
  after_create_commit :notify_recipient
  has_noticed_notifications

  private

  def notify_recipient
    LikeNotification.with(message: self).deliver_later(record.user)
  end
end
