FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Dog owner #{n}" }
    sequence(:email) { |n| "Dog-owner-#{n}@barkbox.com" }
    password { "this is a password" }
  end
end
