require 'factory_girl'
require './spec/factories/presentations'
require './spec/factories/events'
require './spec/factories/users'
require './spec/factories/venues'

10.times {
  Factory(:presentation)
  Factory(:event)
}
