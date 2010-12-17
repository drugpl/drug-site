require 'geocoder'

class Venue < ActiveRecord::Base
  has_many :events
  belongs_to :user
  
  validates :name, :presence => true, :uniqueness => { :scope => :address }
  validates :address, :presence => true
  validates :user, :presence => true

  before_save :geocode_address

  protected

  def geocode_address
    self.latitude, self.longitude = Geocoder.geocode(address)
  end
end
