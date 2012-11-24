class User < ActiveRecord::Base
  has_many :presentations

  validates :full_name, presence: true

  def description
    "Hi my name is and i like doing this and that :)"
  end

  def self.from_omniauth(auth)
    field = 'facebook_uid' if auth.provider == 'facebook'
    field = 'github_uid' if auth.provider == 'github'
    # Is there way to do it simpler?
    where_hash = {}
    where_hash[field] = auth.uid

    if field.present?
      user = where(where_hash).first
      user ||= where(email: auth.info.email).first_or_initialize.tap do |u|
        u.send("#{field}=", auth.uid)
        u.full_name = auth.info.name
        u.email = auth.info.email
        u.save!
      end
    end
    user
  end
end
