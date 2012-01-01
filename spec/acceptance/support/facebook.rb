Capybara.server_port = 3100

RSpec.configure do |config|
  config.before(:each) do
    if example.metadata[:facebook]
      @facebook = Test::Facebook.new(self)
      @user.extend Test::FacebookUser
    end
  end

  config.after(:each) do
    if example.metadata[:facebook]
      @facebook.destroy_test_users
    end
  end
end
