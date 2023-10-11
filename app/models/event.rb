class Event < ApplicationRecord
  belongs_to :user
  validates :event_type, presence: true
  enum event_type: { web_push: 0, mobile_push: 1 }
end
