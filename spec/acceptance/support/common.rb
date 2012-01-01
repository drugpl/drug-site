# encoding: utf-8

RSpec.configure do |config|
  config.before(:each) do
    @user = Test::User.new(self)
    @website = Test::Website.new(self)
    @mail_system = Test::MailSystem.new(self)
  end
end

module Test
  module Base
    extend ActiveSupport::Concern

    included do
      attr_accessor :steak
    end

    module InstanceMethods
      def initialize(steak)
        @steak = steak
        yield if block_given?
        self
      end
    end
  end

  class User
    include Base

    def click(*args)
      steak.click_link_or_button(*args)
      self
    end

    def fill_in(*args)
      steak.fill_in(*args)
      self
    end

    def visit(path)
      steak.visit(path)
      self
    end

    def wait(time)
      sleep(time.to_i)
      self
    end

    def should_see(*args)
      args.each do |arg|
        steak.page.should(steak.have_content(arg.to_s))
      end
      self
    end

    def should_not_see(*args)
      args.each do |arg|
        steak.page.should(steak.have_no_content(arg.to_s))
      end
      self
    end

    def should_see_translated(*args)
      args.each do |arg|
        should_see(I18n.t(arg.to_s))
      end
      self
    end

    def should_not_see_translated(*args)
      args.each do |arg|
        should_not_see(I18n.t(arg.to_s))
      end
      self
    end

    def should_see_image(alt)
      steak.page.should(steak.have_css("img[alt='#{alt}']"))
      self
    end

    def should_not_see_image(alt)
      steak.find_link('Warunki korzystania z usługi')
      steak.page.should(steak.have_no_css("img[alt='#{alt}']"))
      self
    end

    def should_find_map
      self
    end

    def should_find_comments
      steak.page.should(steak.have_selector("#dsq-comments"))
      # steak.page.should(steak.have_selector("#dsq-new-post"))
    end

    def should_find_twitter_entries
      steak.page.should(steak.have_selector(".tweet_list"))
    end

    def click_translated(link)
      steak.click_link_or_button(I18n.t(link.to_s))
      self
    end

    def should_discover_rss(path)
      steak.page.should(steak.have_selector(%Q{link[rel="alternate"][type="application/rss+xml"][href="#{path}"]}))
      self
    end
  end

  class MailSystem
    include Base
    include EmailSpec::Helpers
    include EmailSpec::Matchers

    def should_send_email(options = {})
      email = ActionMailer::Base.deliveries.last
      email.should deliver_to(options[:to]) if options[:to]
      email.should deliver_from(options[:from]) if options[:from]
      # XXX: fix email_spec error with undefined matchers
      # email.should have_subject(/#{options[:message]}/) if options[:message]
    end
  end

  class Website
    include Base

    def has(factory, options = {})
      Factory(factory, options)
    end
  end

  module FacebookUser
    def login_to_facebook(facebook)
      test_user = facebook.create_test_user
      visit "https://www.facebook.com"
      visit test_user.login_url
      @facebook_user = test_user.fetch
    end

    def facebook_name
      @facebook_user.name
    end
  end

  class Facebook
    include Base

    def initialize(*)
      super
      @test_users = []

      # For some reason content created by test users is not visible when using
      # application's access token. Thus we use admin_user's token.
      AttendantsController.any_instance.stubs(:facebook_access_token).returns(admin_user.access_token)
    end

    def has_event(options = {})
      admin_user.event!(options).fetch
    end

    def create_test_user
      permissions = "read_stream,create_event,rsvp_event,user_events"
      @test_users << app.test_user!(installed: true, permissions: permissions)
      @test_users.last
    end

    def destroy_test_users
      @test_users.map(&:destroy)
    end

    protected

    def app
      @app ||= FbGraph::Application.new(AppConfig[:facebook_app_id], secret: AppConfig[:facebook_app_secret])
    end

    def admin_user
      @admin_user ||= create_test_user
    end
  end
end
