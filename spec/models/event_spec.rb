require 'rails_helper'

RSpec.describe Event, type: :model do
  context 'validate event' do
    let(:user) { create(:user) }

    it "should be invalid event without user" do
      event_without_user = build(:event, :without_user)

      expect(event_without_user).to_not be_valid
    end

    it "should be invalid without event type" do
      event_without_event_type = build(:event, :without_event_type)

      expect(event_without_event_type).to_not be_valid
    end

    it 'raises an ArgumentError for an invalid event_type' do
      expect {
        build(:event, :wrong_event_type)
      }.to raise_error(ArgumentError, "'wrong_event_type' is not a valid event_type")
    end

    it "should be valid with event type is web push" do
      event_with_web_push_event_type = build(:event, :web_push, user: user)

      expect(event_with_web_push_event_type).to be_valid
    end

    it "should be valid with event type is mobile push" do
      event_with_mobile_push_event_type = build(:event, :mobile_push, user: user)

      expect(event_with_mobile_push_event_type).to be_valid
    end

    it 'triggers send_email after creating a mobile_push event' do
      iterable_io = instance_double(IterableIoService)
      allow(IterableIoService).to receive(:new).and_return(iterable_io)
      allow(iterable_io).to receive(:send_email)

      event = build(:event, :mobile_push, user: user)
      event.save

      expect(iterable_io).to have_received(:send_email).with(user)
    end
  end
end
