[![Gem Version](https://badge.fury.io/rb/xkpassword.svg)](https://badge.fury.io/rb/xkpassword)
[![Build Status](https://travis-ci.org/jdeen/xkpassword.svg?branch=master)](https://travis-ci.org/jdeen/xkpassword)
[![Inline docs](http://inch-ci.org/github/jdeen/xkpassword.svg?branch=master)](http://inch-ci.org/github/jdeen/xkpassword)
[![Code Climate](https://codeclimate.com/github/jdeen/xkpassword/badges/gpa.svg)](https://codeclimate.com/github/jdeen/xkpassword)

# XKPassword

A password is a key for a lock. The more secure the lock, the more complicated the key would
be. The idea of locking things up is to keep them safe from unwanted parties accessing it
while you can still easily access it. But is it the case with most password generators? The
generated psswords are hard to remember and most of the time you your self are locked out
in times of need.

Bjoern Rennhak, the CTO of [Orpiva](https://www.orpiva.com), Skyped me an interesting cartoon,
that mentioned about the security of passwords that contain just few words been stronger
than those strong passwords generated. I didn't believe it, but the math sure does add up.

Here is a lib that you can use to generate passwords in your Ruby applications or a
command line utility which you can use to generate passwords standalone.

While there are some more planned updates over the next few months, this is what I need for
my new blog. Thus I will pause development for a while and go back to make my website/blog.
If you do have any suggestions, I would be glad to hear. Make an issue and lets talk about
it.

<p align="center">
  <img src="https://imgs.xkcd.com/comics/password_strength.png"/>
</p>

## Installation

Developed in Linux/Ubuntu, this should work fine on Linux machines. I cannot say
the same is true with Mac or Windows systems.

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

Installing the gem also installs the `xkpassword` executable.

## Usage

You can use this app as a Ruby gem in your application or as a command line utility.
For a fuller guide to presets and examples, see [doc/README.md](doc/README.md).

### Command Line

The command line app accepts the same generation options as `XKPassword.generate`.
If you installed the gem, use the executable directly. If you are working from a
checkout, run the executable through Bundler.

```bash
~# xkpassword
~# xkpassword --help
~# bundle exec exe/xkpassword
```

#### Global CLI config

The CLI reads optional defaults from `~/.xkpassword`. The file uses YAML, so it can
include comments while you experiment with different settings. Use `xkpassword --init`
to create a commented starter file.

```bash
~# xkpassword --init
~# xkpassword
~# xkpassword --separator .
```

```yaml
# ~/.xkpassword
# preset: wifi
words: 5
min_length: 4
max_length: 8
separator: "-"
# case_transform: capitalize
```

CLI flags always override values from `~/.xkpassword`, so you can keep preferred defaults
in the file and still override them per command.

### Ruby Apps

Use the library API inside your Ruby application:

```ruby
require 'xkpassword'

options = {
  words: 5,
  min_length: 5,
  max_length: 8,
  separator: '.',
  case_transform: :capitalize,
}

XKPassword.generate(options)
```

You can still use presets when they fit your use case:

```ruby
require 'xkpassword'

XKPassword.generate(preset: :security, separator: '.')
```

If you are generating multiple passwords at once, use a single generator instance so
the dictionary only needs to be loaded once:

```ruby
require 'xkpassword/generator'

options = {
  words: 4,
  min_length: 4,
  max_length: 6,
  separator: '-',
  case_transform: :downcase,
}

generator = XKPassword::Generator.new
generator.generate(options)

# 10.times { generator.generate(options) }
```

`preset` supports `:xkcd` (default), `:web32`, `:wifi`, `:security`, and `:apple_id`.
You can still override any individual option in the selected preset.

The default `:xkcd` preset keeps the gem's original behavior of generating 4 words.

`case_transform` supports `:upcase`, `:downcase`, and `:capitalize`, and applies the
selected transform to every generated word in the password.

## The GEM

Releases are intended for functional updates such as new features and bug fixes.
Check the Git tags or RubyGems release history for the latest published version.

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run 
`bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release
a new version, update the version number in `version.rb`, and then run `bundle exec rake
release`, which will create a git tag for the version, push git commits and tags, and push
the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/xkpassword.
This project is intended to be a safe, welcoming space for collaboration, and contributors
are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of
conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
