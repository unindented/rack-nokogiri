# Rack::Nokogiri [![Version](https://img.shields.io/gem/v/rack-nokogiri.svg)](https://rubygems.org/gems/rack-nokogiri) [![Build Status](https://img.shields.io/travis/unindented/rack-nokogiri.svg)](http://travis-ci.org/unindented/rack-nokogiri) [![Dependency Status](https://img.shields.io/gemnasium/unindented/rack-nokogiri.svg)](https://gemnasium.com/unindented/rack-nokogiri)

Rack Middleware that allows you to manipulate the nodes in your HTML response however you like.


## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'rack-nokogiri'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install rack-nokogiri
```


## Usage

### Adding Rack::Nokogiri to a Rails application

To wrap all `<p>` with class `target` with a `div`, we could do something like this:

```ruby
require 'rack/nokogiri'

class Application < Rails::Application
  config.middleware.use Rack::Nokogiri, css: 'p.target' do |nodes|
    nodes.wrap '<div class="wrapper"></div>'
  end
end
```

If we wanted to use XPath instead of CSS selectors, we could do this instead:

```ruby
require 'rack/nokogiri'

class Application < Rails::Application
  config.middleware.use Rack::Nokogiri, xpath: "//p[@class='target']" do |nodes|
    nodes.wrap '<div class="wrapper"></div>'
  end
end
```

### Adding Rack::Nokogiri to a Sinatra application

For Sinatra we would do:

```ruby
require 'sinatra'
require 'rack/nokogiri'

use Rack::Nokogiri, css: 'p.target' do |nodes|
  nodes.wrap '<div class="wrapper"></div>'
end

get('/') do
  '<p class="target">Hello World!</p>'
end
```

### Adding Rack::Nokogiri to a Rackup application

For a Rackup app we would do:

```ruby
require 'rack'
require 'rack/nokogiri'

use Rack::Nokogiri, css: 'p.target' do |nodes|
  nodes.wrap '<div class="wrapper"></div>'
end

run lambda { |env|
  [200, {'Content-Type' => 'text/html'}, ['<p class="target">Hello World!</p>']]
}
```


## Meta

* Code: `git clone git://github.com/unindented/rack-nokogiri.git`
* Home: <https://github.com/unindented/rack-nokogiri/>


## Contributors

* Daniel Perez Alvarez ([unindented@gmail.com](mailto:unindented@gmail.com))


## License

Copyright (c) 2013 Daniel Perez Alvarez ([unindented.org](https://unindented.org/)). This is free software, and may be redistributed under the terms specified in the LICENSE file.
