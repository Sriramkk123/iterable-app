class Event < ApplicationRecord
  belongs_to :user
  validates :event_type, presence: true
  enum event_type: { web_push: 0, mobile_push: 1 }

  after_commit :send_email_for_mobile_push, if: :mobile_push_event?

  private

  def mobile_push_event?
    event_type == 'mobile_push'
  end

  def send_email_for_mobile_push
    iterable_service = IterableIoService.new(ENV["iterable_io_api_key"])
    iterable_service.send_email(user)
  end
end
