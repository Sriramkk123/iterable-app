class EventsController < ApplicationController
  before_action :authenticate_user!

  def web_push
    iterable_io_service = IterableIoService.new("dummy_key")
    @user = current_user
    @event = @user.events.create({ name: 'web push', event_type: :web_push })
    iterable_io_service.create_web_push_event(@user, @event)
  end

  def mobile_push
    iterable_io_service = IterableIoService.new("dummy_key")
    @user = current_user
    @event = @user.events.create({ event_type: :mobile_push })
    iterable_io_service.create_mobile_push_event(@user, @event)
  end

end