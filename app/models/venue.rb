require 'geocoder'

class Venue < ActiveRecord::Base
  has_many :events
  belongs_to :user
  
  validates :name, :presence => true, :uniqueness => { :scope => :address }
  validates :address, :presence => true
  validates :user, :presence => true

  before_save :geocode_address

  def full_location
    "#{name}, #{address}"
  end

  def has_geo?
    latitude.present? && longitude.present?
  end

  protected

  def geocode_address
    self.latitude, self.longitude = Geocoder.geocode(address)
  end
end
