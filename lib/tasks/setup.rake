namespace :setup do
  desc "Prepare development environment for OSX/Pow"
  task :pow => [:default] do
    FileUtils.cp Rails.root.join('.env'), Rails.root.join('.powenv')
    `sed -e 's/^/export /' -E -i '' #{Rails.root.join('.powenv')}`
    `ln -sf #{Rails.root} ~/.pow/drug`
  end

  desc "Prepare development environment"
  task :default do
    FileUtils.cp Rails.root.join('config/database.yml.tmp'), Rails.root.join('config/database.yml')
  end
end
