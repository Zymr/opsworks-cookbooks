begin
  require "chefspec"
  require "chefspec/berkshelf"
rescue LoadError
  puts "Unable to run `chefspec`"
  exit
end

RSpec.configure do |config|
  config.platform  = "ubuntu"
  config.version   = "14.04"
  config.log_level = :error
end

def add_apt_repository(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:apt_repository, :add, resource_name)
end

def remove_apt_repository(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(
    :apt_repository, :remove, resource_name
  )
end

at_exit { ChefSpec::Coverage.report! }
