require 'minitest/autorun'
require 'minitest/reporters'
require 'rack/test'
require 'nokogiri'

require File.expand_path('../support/expectations', __FILE__)
require File.expand_path('../../lib/rack/nokogiri', __FILE__)

include Rack::Test::Methods

MiniTest::Reporters.use! MiniTest::Reporters::SpecReporter.new

def create_app(status, headers, content, options, &block)
  app = lambda { |env| [status, headers, [content]] }
  Rack::Nokogiri.new(app, options, &block)
end
