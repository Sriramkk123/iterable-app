require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Event' do
    context 'validate event' do
      let(:user) { create(:user) }

      it "should be invalid event without user" do
        event_without_user = build(:event)
        expect(event_without_user).to_not be_valid
      end

      it "should be invalid with nil event type" do
        event_without_event_type = build(:event)
        event_without_event_type.event_type = nil

        expect(event_without_event_type).to_not be_valid
      end

      it 'raises an ArgumentError for an invalid event_type' do
        expect {
          Event.create(event_type: 'wrong_event_type')
        }.to raise_error(ArgumentError, "'wrong_event_type' is not a valid event_type")
      end

      it "should be valid with event type is web push" do
        event_with_web_push_event_type = build(:event, :web_push)
        event_with_web_push_event_type.user_id = user.id

        expect(event_with_web_push_event_type).to be_valid
      end

      it "should be valid with event type is mobile push" do
        event_with_mobile_push_event_type = build(:event, :mobile_push)
        event_with_mobile_push_event_type.user_id = user.id

        expect(event_with_mobile_push_event_type).to be_valid
      end

    end
  end
end
