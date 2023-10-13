class FailedToCreateEventException < StandardError
  def initialize(message = "Failed to create event")
    super
  end
end