require "sinatra/base"
require "disel_router"
require "rspec"
require "rack/test"

class TestController < Sinatra::Base; end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
