class RiCalTemplate < ActionView::Template::Handler
  include ActionView::Template::Handlers::Compilable

  self.default_format = Mime::ICS

  def compile(template)
    "RiCal.Calendar { |cal| #{template.source} }.to_s"
  end
end
