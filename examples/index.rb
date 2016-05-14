require "sinatra/base"
require "disel_router"

module HelloRoutes
  include Disel::Router
  route :get, '/', :index
end

class HelloController < Sinatra::Base
  include HelloRoutes

  def index
    'Hello!'
  end

  run!
end
