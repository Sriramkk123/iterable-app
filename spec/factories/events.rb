FactoryBot.define do
  factory :event do
    name { "event" }
    user
    event_type { 'web_push' }

    trait :without_user do
      user { nil }
    end

    trait :without_event_type do
      event_type { nil }
    end

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
