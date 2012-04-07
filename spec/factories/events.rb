# encoding: utf-8

FactoryGirl.define do
  sequence :title do |n|
    "DRUG ##{n}"
  end

  factory :event do
    title       Factory.next(:title)
    description "Zapraszamy na kolejną edycję DRUGa, w pubie w samym centrum Wrocławia. Czekamy na zgłoszenia prezentacji oraz krótkich lightning talków. Po prezentacjach część nieoficjalna do ostatniego gościa."
    starting_at DateTime.parse("2012-04-16 19:00")
    association :venue
  end
end
