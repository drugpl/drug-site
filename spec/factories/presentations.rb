# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :presentation do
    sequence(:title) { |n| "presentation_title_#{n}" }
    association :user
  end
end
