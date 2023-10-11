class Event < ApplicationRecord
  belongs_to :user
  enum :event_type, { web_push: 0, mobile_push: 1 }
end
