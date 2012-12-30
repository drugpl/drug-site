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

  def photo_url
    "https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-ash4/307354_258526054191173_1375735055_n.jpg"
  end
end
