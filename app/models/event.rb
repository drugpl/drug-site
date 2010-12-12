class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  
  validates :title, :presence => true
  validates :starting_at, :presence => true
  validates :user, :presence => true
  validates :venue, :presence => true
  validates_datetime :ending_at, :after => :starting_at, :allow_nil => true
end
