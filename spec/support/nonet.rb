RSpec.configure do |config|
  config.around(:each) do |example|
    if ENV['NONET'] && example.metadata[:net]
      pending "no network connection"
    else
      example.run
    end
  end
end
