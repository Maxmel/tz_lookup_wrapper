# TzLookupWrapper

Ruby gem wrapper for the blazingly fast coordinate to timezone lookup functionality offered by npm package tz-lookup found here : https://github.com/darkskyapp/tz-lookup

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tz_lookup_wrapper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tz_lookup_wrapper

## Usage

```ruby
require('tz_lookup_wrapper')
TzLookupWrapper.lookup(43.7, -79.4) # => "America/Toronto"
```
## Todo

1. Rewrite the actual tz-lookup library in pure ruby. 
2. ????
3. PROFIT!

## Contributing

1. Fork it ( https://github.com/rajiteh/tz_lookup_wrapper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
