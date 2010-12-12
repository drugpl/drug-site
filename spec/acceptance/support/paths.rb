module NavigationHelpers
  # Put helper methods related to the paths in your application here.

  def homepage
    "/"
  end

  def events_index
    "/events"
  end

  def event_page(event)
    "events/#{event.id}"
  end
end

RSpec.configuration.include NavigationHelpers, :type => :acceptance
