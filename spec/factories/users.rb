# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:full_name) { "full_name_#{n}" }
    sequence(:email) { "full_name_#{n}@example.net" }
  end
end
