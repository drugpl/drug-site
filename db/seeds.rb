require 'factory_girl_rails'

10.times {
  FactoryGirl.create(:presentation)
  FactoryGirl.create(:event)
}
