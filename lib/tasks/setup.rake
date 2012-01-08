task :setup do
  puts 'Copying configuration files...'
  Dir[Rails.root.join('config/*.yml.tmp')].each do |filename|
    FileUtils.cp filename, filename[0...-4]
  end
end
