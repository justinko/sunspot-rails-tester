require 'rubygems'
require 'bundler'
Bundler.setup

require 'sunspot-rails-tester'

RSpec.configure do |config|
  config.color = true
end
