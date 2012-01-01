require 'textilized_attributes'

class Event < ActiveRecord::Base
  include TextilizedAttributes

  belongs_to :user
  belongs_to :venue

  extend FriendlyId
  friendly_id :title, :use => :slugged

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

  def attendants(options = {})
    if has_facebook_event?
      FbGraph::Query.new("
        SELECT uid, name, pic_square, profile_url
        FROM user
        WHERE uid IN (
          SELECT uid FROM event_member WHERE eid='#{facebook_id}' AND rsvp_status='attending'
        )
      ").fetch(options[:access_token] || access_token)
    else
      []
    end
  end

  protected

  def access_token
    @access_token ||= begin
      app = FbGraph::Application.new(AppConfig[:facebook_app_id], :secret => AppConfig[:facebook_app_secret])
      app.get_access_token
    end
  end
end
