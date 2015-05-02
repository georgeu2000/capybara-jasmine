# Gems
require 'rack'

# App
require_relative 'builder'
require_relative 'spec_injector'

puts "Starting Capybara Jasmine in #{ ENV[ 'RACK_ENV' ]} environment."