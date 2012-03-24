desc "Prepare development environment"
task :setup do
  database_setup
  facebook_setup
  google_maps_setup
  email_setup
end

def database_setup
  copy_example('database.yml.tmp')
end

def facebook_setup
  copy_example('facebook.yml.tmp')
end

def google_maps_setup
  copy_example('google_maps.yml.tmp')
end

def email_setup
  copy_example('email.yml.tmp')
end

def copy_example(filename)
  path     = Rails.root.join('config', filename).to_s
  ext_size = File.extname(filename).size
  FileUtils.cp path, path[0...-ext_size]
end
