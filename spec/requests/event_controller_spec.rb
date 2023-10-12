require 'rails_helper'
require 'webmock/rspec'

RSpec.describe EventsController, type: :request do
  let(:user) { create(:user) }

  describe 'POST /events/web_push' do

    before do
      sign_in user
      stub_request(:post, "https://api.iterable.com/api/events/trackWebPushClick")
        .to_return(status: 200, body: "", headers: {})
    end

    it 'makes trackWebPushClick api call' do
      post events_web_push_path

      expect(WebMock).to have_requested(:post, "https://api.iterable.com/api/events/trackWebPushClick")
                           .once
    end
  end

  describe "POST /events/mobile_push" do

    before do
      sign_in user
      stub_request(:post, "https://api.iterable.com/api/events/trackPushOpen")
        .to_return(status: 200, body: "", headers: {})
      stub_request(:post, "https://api.iterable.com/api/email/target")
        .to_return(status: 200, body: "", headers: {})
    end

    it 'creates trackPushOpen and email sending api call' do
      post events_mobile_push_path

      expect(WebMock).to have_requested(:post, "https://api.iterable.com/api/events/trackPushOpen")
                           .once
      expect(WebMock).to have_requested(:post, "https://api.iterable.com/api/email/target")
                           .once
    end
  end
end