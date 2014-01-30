class PresentationPresenter
  attr_accessor :presentation

  def initialize(presentation)
    @presentation = presentation
  end

  def as_json(*)
    {
      :id => id,
      :title => title,
      :speaker_full_name => speaker_full_name,
      :speaker_avatar => avatar_url
    }
  end

  def speaker
    users.first
  end

  def speaker_full_name
    speaker.full_name
  end

  def avatar_url
    "https://www.gravatar.com/avatar/#{email_digest}?d=identicon"
  end

  def email_digest
    Digest::MD5.hexdigest(speaker.email)
  end

  delegate :id, :title, :users, :to => :presentation
end
