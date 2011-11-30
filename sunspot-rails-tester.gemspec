# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'sunspot/rails/tester'

Gem::Specification.new do |s|
  s.name        = 'sunspot-rails-tester'
  s.version     = Sunspot::Rails::Tester::VERSION
  s.platform    = Gem::Platform::RUBY
  s.author      = 'Justin Ko'
  s.email       = 'jko170@gmail.com'
  s.homepage    = 'https://github.com/justinko/sunspot-rails-tester'
  s.summary     = 'Stub sunspot when you want, and enable it when you want'
  s.description = 'Enable sunspot during testing for *real* integration tests'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_path  = 'lib'

  s.add_dependency 'sunspot_rails', '~> 1.2'
  s.add_dependency 'sunspot_solr', '~> 1.2'

  s.add_development_dependency 'rspec', '~> 2.5'
end
