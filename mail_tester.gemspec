# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mail_tester/version'

Gem::Specification.new do |gem|
  gem.name          = "mail_tester"
  gem.version       = Mail::Tester::VERSION
  gem.authors       = ["Nicolas Ledez"]
  gem.email         = ["github@ledez.net"]
  gem.description   = %q{A simple gem to test mail server config}
  gem.summary       = %q{Provide user & server config. Gem test server for you}
  gem.homepage      = ""

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('guard')
  gem.add_development_dependency('guard-spork')
  gem.add_development_dependency('guard-rspec')
  gem.add_development_dependency('rb-fsevent', '~> 0.9.1')
  gem.add_development_dependency('ruby_gntp')
  gem.add_development_dependency('simplecov')

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
