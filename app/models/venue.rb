class Venue < ActiveRecord::Base
  has_many :events

  validates :name, presence: true, uniqueness: { scope: :address }
  validates :address, presence: true

  def full_location
    "#{name}, #{address}"
  end

  def has_geo?
    latitude.present? && longitude.present?
  end

  def as_json(*)
    {
      name: name,
      address: address,
      location: [latitude, longitude]
    }
  end
end
