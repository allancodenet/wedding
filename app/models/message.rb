class Message < ApplicationRecord
  belongs_to :sender
  has_noticed_notifications
  belongs_to :conversation, touch: true
end
