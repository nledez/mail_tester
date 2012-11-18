require 'rubygems'
require 'spork'
require 'rspec/autorun'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

require 'simplecov'
SimpleCov.start

Spork.prefork do
  require 'rspec'
  RSpec.configure do |config|
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.run_all_when_everything_filtered = true
    config.filter_run :focus

    config.order = 'random'
  end
end

Spork.each_run do
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end
