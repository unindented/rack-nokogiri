# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rack/nokogiri/version'

Gem::Specification.new do |gem|
  gem.name          = 'rack-nokogiri'
  gem.version       = Rack::Nokogiri::VERSION
  gem.authors       = ['Daniel Perez Alvarez']
  gem.email         = ['unindented@gmail.com']
  gem.description   = %q{Rack Middleware for node manipulation.}
  gem.summary       = %q{Rack Middleware that allows you to manipulate the nodes in your response however you like.}
  gem.homepage      = 'http://github.com/unindented/rack-nokogiri'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.required_ruby_version = '>= 1.9.0'

  gem.add_runtime_dependency 'rack',         '>= 1.0.0'
  gem.add_runtime_dependency 'nokogiri',     '>= 1.4.0'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'minitest-reporters'
  gem.add_development_dependency 'rack-test'

  gem.add_development_dependency 'guard-minitest'
  gem.add_development_dependency 'rb-inotify'
  gem.add_development_dependency 'rb-fsevent'
  gem.add_development_dependency 'rb-fchange'
end
