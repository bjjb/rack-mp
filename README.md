# MP

Memory profiler for Rack apps (on Ruby 2)

## Installation

Add this line to your application's Gemfile:

    gem 'mp'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mp

## Usage

Mount MP as a middleware.

Visit a path with `__mp__=counts` somewhere in the query string.

Check the response headers for `X-MP-ObjectCounts`.


## TODO

* Make the header smaller (serialize to "OBJNAME:N1:N2,...", for example)
* Use Ruby 2.1's excellent objspace library to do full object profiling, and
  serve beautiful graphs and whatnot. Mañana.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/mp/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
