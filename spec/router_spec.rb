require "spec_helper"

describe "router engine" do

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

  end

end
