# DiselRouter ![Codeship CI status](https://codeship.com/projects/02d1c690-fdb4-0133-d27c-367994a53831/status?branch=master)

DiselRouter is a module that allows you to separate routes from controllers in
your Sinatra application.

Example usage:
```ruby
require 'sinatra/base'
require 'disel_router'

module HelloRoutes
  include Disel::Router
  route :get, '/', :index
end

class HelloController < Sinatra::Base # Sinatra::Application works too
  include HelloRoutes

  def index
    'Hello!'
  end

  run!
end
```

DiselRouter does not modify or complement standard Sinatra routing features

So doing this:
```ruby
module HelloRoutes
  include Disel::Router
  route :get, '/', :index
end

class HelloController < Sinatra::Base
  include HelloRoutes
end
```

is equal to:

```ruby
class HelloController < Sinatra::Base
  get '/' do
    'Hello!'
  end
end
```
if body of a block was an `:index` method

MIT © Yury Solovyov
