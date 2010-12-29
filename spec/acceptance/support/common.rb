Rspec.configure do |config|
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

      def expects(model_sym, method_sym, options = {})
        stub = Factory.stub(model_sym, options)
        model_sym.to_s.classify.constantize.should_receive(method_sym).and_return(stub)
        stub
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
    
    def should_see(*args)
      args.each do |arg|
        steak.page.should(steak.have_content(arg.to_s))
      end
      self
    end

    def should_not_see(*args)
      args.each do |arg|
        steak.page.should_not(steak.have_content(arg.to_s))
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

    def should_find_map
      if ENV['NONET'] # no internet connection to load maps
        steak.pending
      else
        steak.find_link('Click to see this area on Google Maps')
      end
      self
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
end
