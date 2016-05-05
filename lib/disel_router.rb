module Disel
  module Router
    ROUTES = Hash.new

    def self.included(mod)
      mod.module_eval do |m|

        def m.route(http_method, path, method)
          routes = ROUTES[self]
          if routes.nil?
            ROUTES[self] = Hash.new
            routes = ROUTES[self]
          end
          routes[http_method] = [path, method]
        end

        def m.included(controller)
          routes = ROUTES[self]
          routes.each do |http_method, arr|
            controller.send(http_method, arr.first) do |*args|
              self.send(arr.last, *args)
            end
          end
        end

      end
    end
  end
end
