class Geocoder
  include Geokit::Geocoders

  def self.geocode(address)
    %w(lat lng).map { |fun| MultiGeocoder.geocode(address).send(fun) }
  end
end
