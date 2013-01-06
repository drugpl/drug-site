require 'test_helper'

class EventTest < Bbq::TestCase
  def prepare_actors
    @organizer = TestUser.new
    @guest     = TestUser.new
  end

  setup :prepare_actors

  scenario 'guest should see upcoming event on root page' do
    @organizer.create_upcoming_event 'DRUG #99'
    @guest.visit_root
    @guest.see_event! 'DRUG #99'
  end

  scenario 'guest should see twitter link on root page when no event' do
    @guest.visit_root
    @guest.see_translated! 'events.no_upcoming_event'
    @guest.see! 'twitter'
  end
end
