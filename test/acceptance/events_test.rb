require 'test_helper'

class EventTest < Bbq::TestCase
  setup :prepare_actors

  def prepare_actors
    @organizer = TestUser.new
    @guest     = TestUser.new
  end

  scenario 'guest should see upcoming event on root page' do
    @organizer.create_event('DRUG #99')
    @guest.visit_root
    assert @guest.see_event('DRUG #99')
  end
end
