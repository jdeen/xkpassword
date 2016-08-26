# XKPassword

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/xkpassword`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xkpassword'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xkpassword

## Usage

You can use this app stand-alone in the command line or include it in any of your Ruby
applications.

### Comamnd Line
The commandline application accepts the same collection of configuration options as would
the `XKPassword` module would. For more information use `xkpassword --help` to obtain a
full list of options.

```bash
~# xkpassword
~# xkpassword --help
```

### Ruby Apps

```ruby
require 'xkpassword/generator'

options = {
  max_length: 8,
  min_length: 4,
  separator: '-',
  words: 4,
}

XKPassword.generate(options)
```

If you are generating multiple passwords at once, I recommend you use
the following as then it will only load and parse the databse once.

```ruby
require 'xkpassword/generator'

options = {
  max_length: 8,
  min_length: 4,
  separator: '-',
  words: 4,
}
  
generator = XKPassword::Generator.new
generator.generate(options)

# 10.times { generator.generate(options) }
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xkpassword. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

