require 'bbq/test_user'

class TestUser < Bbq::TestUser
  def visit_root
    visit '/'
  end

  def see_event!(title)
    see! title
  end

  def see_translated!(text)
    see! I18n.t(text)
  end

  def create_event(title, starting_at)
    FactoryGirl.create(:event, starting_at: starting_at, title: title)
  end

  def create_upcoming_event(title)
    create_event(title, 1.month.from_now)
  end
end
