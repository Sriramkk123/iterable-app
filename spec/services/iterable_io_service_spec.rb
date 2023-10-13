require 'rails_helper'
require 'webmock/rspec'


RSpec.describe IterableIoService, type: :service do
  let(:api_key) { 'dummy_api_key' }
  let(:user) { create(:user) }
  WEB_PUSH_CLICK_URL = "https://api.iterable.com/api/events/trackWebPushClick"
  MOBILE_PUSH_CLICK_URL = "https://api.iterable.com/api/events/trackPushOpen"
  SEND_EMAIL_URL = "https://api.iterable.com/api/email/target"

  describe '#create_web_push_event' do
    it 'sends a web push event' do
      event = create(:event, :web_push, user: user)
      service = IterableIoService.new(api_key)

      expect(RestClient).to receive(:post).with(
        WEB_PUSH_CLICK_URL,
        {
          email: user.email,
          messageId: event.id.to_s,
        },
        headers: {
          'Api-Key' => api_key,
          'Content-Type' => 'application/json'
        }
      ).and_return({ status: "200" })

      service.create_web_push_event(user, event)
    end
  end

  describe '#create_mobile_push_event' do
    before do
      stub_request(:post, SEND_EMAIL_URL).
        to_return(status: 200, body: "", headers: {})
    end

    it 'sends a mobile push event' do
      event = create(:event, :mobile_push, user: user)
      service = IterableIoService.new(api_key)

      expect(RestClient).to receive(:post).with(
        MOBILE_PUSH_CLICK_URL,
        {
          email: user.email,
          messageId: event.id.to_s,
        },
        headers: {
          'Api-Key' => api_key,
          'Content-Type' => 'application/json'
        }
      ).and_return({ status: "200" })

      service.create_mobile_push_event(user, event)
    end
  end

  describe '#send_email' do
    it 'sends an email' do
      service = IterableIoService.new(api_key)
      current_time = Time.now
      Timecop.freeze(current_time)

      expect(RestClient).to receive(:post).with(
        SEND_EMAIL_URL,
        {
          recipientEmail: user.email,
          recipientUserId: user.id.to_s,
          sendAt: DateTime.parse(current_time.to_s).strftime("%Y-%m-%d %H:%M:%S"),
          dataFields: {},
        },
        headers: {
          'Api-Key' => api_key,
          'Content-Type' => 'application/json'
        }
      ).and_return({ status: "200" })

      service.send_email(user)
      Timecop.return
    end
  end
end
