module Disel

  class Route
    attr_reader :verb
    attr_reader :args
    attr_reader :method

    def initialize(http_method, args, controller_method)
      @verb = http_method
      @method = controller_method
      @args = args
    end
  end

  module Router

    def self.included(mod)

      mod.module_eval do |m|
        @routes = []

        def m.route(http_verb, *args, controller_method)
          @routes << Route.new(http_verb, args, controller_method)
        end

        def m.included(controller)
          @routes.each do |route|
            controller.send(route.verb, *route.args) do |*args|
              self.send(route.method, *args)
            end
          end
        end

      end

    end

  end
end
