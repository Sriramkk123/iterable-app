FactoryBot.define do
  factory :event do
    name { "web event" }
    user_id { nil }
    event_type { 'web_push' }

    trait :wrong_event_type do
      event_type { 'wrong_event_type' }
    end

    trait :web_push do
      event_type { 'web_push' }
    end

    trait :mobile_push do
      event_type { 'mobile_push' }
    end
  end
end
