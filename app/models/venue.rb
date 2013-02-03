class Venue < ActiveRecord::Base
  attr_accessible :name, :latitude, :longitude, :photo

  has_many :events
  has_attached_file :photo, styles: {
    medium: "350x350>", 
    thumb: "100x100>"
  }

  validates :name, presence: true, uniqueness: { scope: :address }
  validates :address, presence: true

  def name_with_address
    "#{name}, #{address}"
  end

  def has_geo?
    latitude.present? && longitude.present?
  end

  def photo_url
    photo.url(:medium)
    #"https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-ash4/307354_258526054191173_1375735055_n.jpg"
  end
end
