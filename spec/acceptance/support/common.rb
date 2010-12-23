module Test
  class Base
    attr_accessor :steak

    def initialize(steak)
      @steak = steak
      yield if block_given?
      self
    end

    def should_respond_with(object_sym, method_sym)
      stub = Factory.stub(object_sym)
      object_sym.to_s.classify.constantize.should_receive(method_sym).and_return(stub)
    end
  end

  class User < Base
    def click(*args)
      steak.click_link_or_button(*args)
    end
    
    def fill_in(*args)
      steak.fill_in(*args)
    end
    
    def visit(path)
      steak.visit(path)
    end
    
    def should_see(*args)
      args.each do |arg|
        steak.page.should(steak.have_content(arg.to_s))
      end
    end

    def should_see_translated(*args)
      args.each do |arg|
        should_see(I18n.t(arg.to_s))
      end
    end
  end

  class Website < Base
    def has_event(title = nil, description = nil)
      Factory(:event, :title => title, :description => description)
    end

    def should_have_map
      steak.find_link('Click to see this area on Google Maps')
    end
  end
end
