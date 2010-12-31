Factory.sequence :name do |n| 
  "name_#{n}"
end

Factory.sequence :email do |n| 
  "email_#{n}@example.net"
end

Factory.sequence :address do |n| 
  "address_#{n}"
end

Factory.sequence :title do |n| 
  "title_#{n}"
end

Factory.sequence :description do |n| 
  "description_#{n}"
end

Factory.define :user do |u|
  u.email { Factory.next :email }
  u.password "dupa.8"
end

Factory.define :venue do |v|
  v.name { Factory.next :name }
  v.address { Factory.next :address }
  v.association :user
end

Factory.define :event do |e|
  e.title { Factory.next :title }
  e.description { Factory.next :description }
  e.association :user
  e.association :venue
  e.starting_at { Time.now }
end

Factory.define :snippet do |s|
  s.label { Factory.next(:title) }
  s.content { Factory.next(:description) }
end

Factory.define :published_snippet, :parent => :snippet do |s|
  s.status 'published'
end

Factory.define :news_article do |s|
  s.title { Factory.next(:title) }
  s.body { Factory.next(:description) }
  s.created_at { Time.now }
end

Factory.define :published_news_article, :parent => :news_article do |s|
  s.status 'published'
end

Factory.define :contact do |c|
  c.name "test@example.com"
  c.message "Request For Comments 666"
  c.email "test@example.net"
end
