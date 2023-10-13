require 'rails_helper'
require 'webmock/rspec'

RSpec.describe EventsController, type: :request do
  let(:user) { create(:user) }
  WEB_PUSH_CLICK_URL = "https://api.iterable.com/api/events/trackWebPushClick"
  MOBILE_PUSH_CLICK_URL = "https://api.iterable.com/api/events/trackPushOpen"
  SEND_EMAIL_URL = "https://api.iterable.com/api/email/target"

  describe 'POST /events/web_push' do

    before do
      sign_in user
      stub_request(:post, WEB_PUSH_CLICK_URL)
        .to_return(status: 200, body: "", headers: {})
    end

    it 'makes trackWebPushClick api call' do
      post events_web_push_path

      expect(WebMock).to have_requested(:post, WEB_PUSH_CLICK_URL)
                           .once
    end
  end

  describe "POST /events/mobile_push" do

    before do
      sign_in user
      stub_request(:post, MOBILE_PUSH_CLICK_URL)
        .to_return(status: 200, body: "", headers: {})
      stub_request(:post, SEND_EMAIL_URL)
        .to_return(status: 200, body: "", headers: {})
    end

    it 'creates trackPushOpen and email sending api call' do
      post events_mobile_push_path

      expect(WebMock).to have_requested(:post, MOBILE_PUSH_CLICK_URL)
                           .once
      expect(WebMock).to have_requested(:post, SEND_EMAIL_URL)
                           .once
    end
  end
end