# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :presentation_type do
    sequence(:name) {|n| "Presentation Type #{n}"}
  end
end
