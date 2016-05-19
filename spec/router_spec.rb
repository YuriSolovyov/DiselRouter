require "spec_helper"

describe "router engine" do
  include Rack::Test::Methods

  describe "when included to module" do

    let(:routing_module) { Module.new.include(Disel::Router) }

    it "should add route method" do
      allow(routing_module).to receive(:route)
    end

  end

  describe "when argumented module included to controller" do

    let(:routes) do
      Module.new do
        include Disel::Router
        route :get, '/', :index
        route :post, '/create', :add_post
        route :delete, '/:id/delete', :delete_post
      end
    end

    let (:controller) { TestController }

    it "should create routes" do
      ctrl = controller

      expect(ctrl).to receive(:get).with('/')
      expect(ctrl).to receive(:post).with('/create')
      expect(ctrl).to receive(:delete).with('/:id/delete')

      ctrl.include(routes)
    end

    def app
      controller.class_eval do
        def index
          "index"
        end

        def add_post
          "add_post"
        end

        def delete_post(id)
          "delete_post_#{id}"
        end
      end
      controller.include(routes)
    end

    it "should make controller respond to actions" do

      get '/'
      expect(last_response.body).to eq('index')

      post '/create'
      expect(last_response.body).to eq('add_post')

      delete '/42/delete'
      expect(last_response.body).to eq('delete_post_42')

    end

  end

end
