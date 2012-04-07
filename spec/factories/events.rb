# encoding: utf-8

FactoryGirl.define do
  factory :event do
    sequence(:title) { |n| "DRUG ##{n}" }
    description "Zapraszamy na kolejną edycję DRUGa, w pubie w samym centrum Wrocławia. Czekamy na zgłoszenia prezentacji oraz krótkich lightning talków. Po prezentacjach część nieoficjalna do ostatniego gościa."
    starting_at DateTime.parse("2012-04-16 19:00")
    association :venue
  end
end
