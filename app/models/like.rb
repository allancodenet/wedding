class Like < ApplicationRecord
  belongs_to :client
  belongs_to :record, polymorphic: true, counter_cache: true
end
