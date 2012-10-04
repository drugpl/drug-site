# encoding: utf-8

FactoryGirl.define do
  factory :venue do
    sequence(:name) {|i| "Pub nr #{i}"}
    address   "Wrocław, ul. Kościuszki 34 (Pałacyk)"
    latitude  50
    longitude 50
  end
end
