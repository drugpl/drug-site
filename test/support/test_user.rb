require 'bbq/test_user'

class TestUser < Bbq::TestUser
  def visit_root
    visit '/'
  end

  def see_event(title)
    see title
  end

  def create_event(title)
    FactoryGirl.create(:event)
  end
end
