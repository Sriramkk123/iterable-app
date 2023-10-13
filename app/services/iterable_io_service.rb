class IterableIoService

  def initialize(api_key)
    @api_key = api_key
    @base_url = "https://api.iterable.com/api/"
  end

  def create_web_push_event(user, event)
    request_body = get_request_body(event, user)
    begin
      RestClient.post("#{@base_url}events/trackWebPushClick", request_body, headers: {
        'Api-Key' => @api_key,
        'Content-Type' => 'application/json'
      })
    rescue RestClient::ExceptionWithResponse => err
      puts err.to_s
      raise FailedToCreateEventException, "Failed to create web push event"
    end
  end

  def create_mobile_push_event(user, event)
    request_body = get_request_body(event, user)
    begin
      RestClient.post("#{@base_url}events/trackPushOpen", request_body, headers: {
        'Api-Key' => @api_key,
        'Content-Type' => 'application/json'
      })
    rescue RestClient::ExceptionWithResponse => err
      puts err.to_s
      raise FailedToCreateEventException, "Failed to create mobile push event"
    end
  end

  def send_email(user)
    request_body = {
      "recipientEmail": user.email,
      "recipientUserId": user.id.to_s,
      "sendAt": DateTime.parse(Time.now.to_s).strftime("%Y-%m-%d %H:%M:%S"),
      "dataFields": {},
    }
    begin
      RestClient.post("#{@base_url}email/target", request_body, headers: {
        'Api-Key' => @api_key,
        'Content-Type' => 'application/json'
      })
    rescue RestClient::ExceptionWithResponse => err
      puts err.to_s
    end
  end

  private

  def get_request_body(event, user)
    {
      "email": user.email,
      "messageId": event.id.to_s,
    }
  end
end