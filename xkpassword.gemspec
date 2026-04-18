# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'xkpassword/version'

Gem::Specification.new do |spec|
  spec.name          = 'xkpassword'
  spec.version       = XKPassword::VERSION
  spec.authors       = ['Ziyan Junaideen']
  spec.email         = ['ziyan@jdeen.com']

  spec.summary       = 'Hard to crack - XKPassword Generator for Ruby'
  spec.description   = <<~DESCRIPTION
    Passwords are hard to remember, especially when they are hard to crack. I'd spend countless hours
    every year resetting passwords and eventually running out of options that I can remember. I found
    an interesting concept in an XKCD comic: generate passwords using words so they are easier to
    remember. Here is XKPassword, a library you can install into your Ruby app or run independently
    from the command line.

    Wish you a safer future.

    Ziyan
  DESCRIPTION
  spec.homepage      = 'https://github.com/jdeen/xkpassword'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3', '< 4.1')
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  spec.files         = `git ls-files -z`.split("\x0").reject { |file| file.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ['lib']

  spec.add_dependency 'artii', '~> 2.1'
  spec.add_development_dependency 'bundler', '>= 2.5', '< 3.0'
  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rspec', '~> 3.13'
end
