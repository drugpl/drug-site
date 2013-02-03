require 'minitest_helper'

class TestMeme < MiniTest::Unit::TestCase
  def setup
    @event = Event.new
  end

  # I know that these tests are pretty dumb and basic,
  #   but I use minitest first time, so I wanted to write sth simple.
  def test_future_if_event_not_happened
    @event.starting_at = Time.now + 1.month
    assert @event.future?
  end

  def test_future_if_event_happened
    @event.starting_at = Time.now - 1.month
    refute @event.future?
  end

  
end