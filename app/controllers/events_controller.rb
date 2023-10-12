class EventsController < ApplicationController
  before_action :authenticate_user!, :initialize_iterable_io_service

  def web_push
    create_event(:web_push)
    @iterable_io_service.create_web_push_event(@user, @event)
  end

  def mobile_push
    create_event(:mobile_push)
    @iterable_io_service.create_mobile_push_event(@user, @event)
  end

  private

  def initialize_iterable_io_service
    @iterable_io_service = IterableIoService.new("dummy_key")
  end

  def create_event(event_type)
    @user = current_user
    @event = @user.events.create({ name: event_type, event_type: event_type })
  end

end