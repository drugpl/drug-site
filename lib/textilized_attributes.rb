require 'RedCloth'

module TextilizedAttributes
  extend ActiveSupport::Concern

  module ClassMethods
    def textilized_attrs(*args)
      args.each do |attribute|
        define_method "textilized_#{attribute}" do
          textilize(send(attribute))
        end
      end
    end
  end
end
