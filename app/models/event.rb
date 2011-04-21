require 'textilized_attributes'

class Event < ActiveRecord::Base
  include TextilizedAttributes

  belongs_to :user
  belongs_to :venue

  has_friendly_id :title, :use_slug => true, :approximate_ascii => true
  
  validates :title, :presence => true
  validates :description, :presence => true
  validates :starting_at, :presence => true
  validates :user, :presence => true
  validates :venue, :presence => true
  validates_datetime :ending_at, :after => :starting_at, :allow_nil => true

  delegate :name, :address, :latitude, :longitude, :to => :venue, :prefix => true

  scope :happened, lambda { where("starting_at < ?", Time.zone.now) }

  cattr_accessor :per_page  
  @@per_page = 5

  textilized_attrs :description

  def future?
    starting_at > Time.now
  end

  def has_facebook_event?
    !! facebook_id
  end

  def facebook_event
    @facebook_event ||= FacebookEvent.new(facebook_id)
  end

  def attendants
    if has_facebook_event?
      facebook_event.attendants
    else
      []
    end
  end
end
