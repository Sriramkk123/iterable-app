FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'abcd123' }
  end
end
