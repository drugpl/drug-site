# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :person do
    sequence(:full_name) {|n| "full_name_#{n}" }
    sequence(:email) {|n| "full_name_#{n}@example.net" }
  end
end
