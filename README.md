# XKPassword

A password is a key for a lock. The more secure the lock, the more complicated the key would
be. The idea of locking things up is to keep them safe from unwanted parties accessing it
while you can still easily access it. But is it the case with most password generators? The
generated psswords are hard to remember and most of the time you your self are locked out
in times of need.

Bjoern Rennhak, the CTO of ClothesNetwork (now Graylon), Skyped me an interesting cartoon,
that mentioned about the security of passwords that contain just few words been stronger
than those strong passwords generated. I didn't believe it, but the math sure does add up.

Here is a lib that you can use to generate passwords in your Ruby applications or a
command line utility which you can use to generate passwords standalone.

While there are some more planned updates over the next few months, this is what I need for
my new blog. Thus I will pause development for a while and go back to make my website/blog.
If you do have any suggestions, I would be glad to hear. Make an issue and lets talk about
it.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xkpassword'
```

And then execute:

```bash
~# bundle
```

Or install it yourself as:

```bash
~# gem install xkpassword
```

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
require 'xkpassword'

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

After checking out the repo, run `bin/setup` to install dependencies. You can also run 
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release
a new version, update the version number in `version.rb`, and then run `bundle exec rake
release`, which will create a git tag for the version, push git commits and tags, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO

Some of the things I am interested in doing in the near future.

- Local configuration file -> ex: `~/.xkpassword`
- Check for a better dictionary
- Ability to provide a dictionary (this should help languages other than English)
- A black-list - words that will not show up in the generation

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xkpassword.
This project is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

