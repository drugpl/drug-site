class User < ActiveRecord::Base
  has_many :presentations

  has_many :participations
  has_many :events, through: :participations

  validates :full_name, presence: true

  scope :publicized, where(publicized: true)

  PresentationsKarma = 3
  IrcPointsKarma = 1

  def description
    "Hi my name is and i like doing this and that :)"
  end

  def attend(event)
    if events.include?(event)
      :already_signed
    else
      events << event
      if save
        :signed
      else
        :error
      end
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
    user = where({ "#{auth.provider}_uid" => auth.uid }).first
    user ||= where(email: auth.info.email).first_or_initialize
    user.add_omniauth_properties(auth)
    user
  end
end
