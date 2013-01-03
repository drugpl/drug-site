class Person < ActiveRecord::Base
  class AlreadySignedException < StandardError; end

  attr_accessible :full_name, :irc_nickname, :rss_url, :description

  has_and_belongs_to_many :presentations, foreign_key: :person_id
  has_many :participations
  has_many :events, through: :participations

  validates :irc_nickname, uniqueness: true, allow_blank: true

  scope :publicized, where(publicized: true)

  PresentationsKarma = 3
  IrcPointsKarma = 1

  def attend!(event)
    if events.include?(event)
      raise AlreadySignedException
    else
      events << event
      save
    end
  end

  def change_membership!
    self.publicized = !self.publicized
    save!
  end

  def attend?(event)
    events.include?(event)
  end

  def amount_of_presentations
    self.presentations.done.count
  end

  def amount_of_participations
    @amount_of_participations ||= rand(Event.count)
  end

  def participant?
    amount_of_participations > 0
  end

  def karma
    (self.irc_points * IrcPointsKarma) +
      (self.amount_of_presentations * PresentationsKarma)
  end

  def add_omniauth_properties(auth)
    self.send("#{auth.provider}_uid=", auth.uid)

    if new_record?
      self.full_name = auth.info.name
      self.email = auth.info.email
    end

    case auth.provider
      when 'github'
        self.github_nickname = auth.info.nickname
    end

    save!
  end

  def self.from_omniauth(auth)
    person = where({ "#{auth.provider}_uid" => auth.uid }).first
    person ||= where(email: auth.info.email).first_or_initialize
    person.add_omniauth_properties(auth)
    person
  end
end
