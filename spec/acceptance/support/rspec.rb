Rspec.configure do |config|
  config.before(:each) do
    Capybara.current_driver = :selenium if example.metadata[:js]
    @user = Test::User.new(self)
    @website = Test::Website.new(self)
  end

  config.after(:each) do
    Capybara.use_default_driver if example.metadata[:js]
  end
end
