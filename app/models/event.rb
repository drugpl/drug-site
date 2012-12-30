class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :presentations

  has_many :participations
  has_many :users, through: :participations

  extend FriendlyId
  friendly_id :title, use: :slugged

  validates :title, presence: true
  validates :description, presence: true
  validates :starting_at, presence: true
  validates :venue, presence: true

  delegate :name, :address, :latitude, :longitude, to: :venue, prefix: true

  scope :happened, lambda { where("starting_at < ?", Time.zone.now) }
  scope :previous, lambda { order("id desc").limit(30).offset(1) }
  scope :recent, lambda { order("starting_at DESC") }

  paginates_per 5

  def future?
    starting_at > Time.now
  end

  def has_facebook_event?
    !! facebook_id
  end

  # def attendants(options = {})
  #   if has_facebook_event?
  #     FbGraph::Query.new("
  #       SELECT uid, name, pic_square, profile_url
  #       FROM user
  #       WHERE uid IN (
  #         SELECT uid FROM event_member WHERE eid='#{facebook_id}' AND rsvp_status='attending'
  #       )
  #     ").fetch(options[:access_token] || access_token)
  #   else
  #     []
  #   end
  # end

  # protected

  # def access_token
  #   @access_token ||= begin
  #     app = FbGraph::Application.new(Settings.facebook[:app_id], secret: Settings.facebook[:app_secret])
  #     app.get_access_token
  #   end
  # end
end
