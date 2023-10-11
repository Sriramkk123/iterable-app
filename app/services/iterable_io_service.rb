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
    end
  end

  private

  def get_request_body(event, user)
    {
      "email": user.email,
      "userId": user.id,
      "messageId": event.id.to_s,
      "clickedUrl": "https://www.iterable.com"
    }
  end
end