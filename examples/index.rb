require "sinatra/base"
require "disel_router"

module HelloRoutes
  include Disel::Router

  route :get, '/', { agent: /Chrome/ }, :chrome_index

  route :get, '/', :index
end

class HelloController < Sinatra::Base
  include HelloRoutes

  def index
    'Hello!'
  end

  def chrome_index
    'Hello Chrome!'
  end

  run!
end
