class RiCalTemplate
  class_attribute :default_format
  self.default_format = Mime::ICS

  def self.call(template)
    "RiCal.Calendar { |cal| #{template.source} }.to_s"
  end
end
