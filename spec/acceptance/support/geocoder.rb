RSpec.configure do |config|
  config.before(:each) do
    Geocoder.stub!(:geocode).and_return([0.0, 0.0])
  end
end
