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

  def amount_of_presentations
    self.presentations.count
  end

  def karma
    (self.irc_points * IrcPointsKarma) +
      (self.amount_of_presentations * PresentationsKarma)
  end

  Fields = {
    github: [],
    facebook: []
  }

  def self.from_omniauth(auth)
    user = where({ "#{auth.provider}_uid" => auth.uid }).first
    user ||= where(email: auth.info.email).first_or_initialize.tap do |u|
      u.send("#{auth.provider}_uid=", auth.uid)

      if u.new_record?
        u.full_name = auth.info.name
        u.email = auth.info.email
      end

      # Provider-specific fields
      Fields.each do |field|
        u.send("#{auth.provider}_#{field}=", auth.send(field))
      end

      u.save!
    end
    user
  end
end
