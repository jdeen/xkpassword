# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xkpassword/version'

Gem::Specification.new do |spec|
  spec.name          = "xkpassword"
  spec.version       = XKPassword::VERSION
  spec.authors       = ["Ziyan Junaideen"]
  spec.email         = ["ziyan@jdeen.com"]

  spec.summary       = %q{Hard to crack - XKPassword Generator for Ruby}
  spec.description   = """
  Passwords are hard to remember, specially when they are hard to crack. I'd spend countless hours
  every eyar resetting passwords and eventually running out of options that I can remember. I found
  an interesting concept among a comic XKCD, it is to generate passwords using words and thus easier
  to remember. Here is XKPassword, a lib which you can install to our Ruby app or run indipendant
  in the command line.

  Wish you a safer future.

  Ziyan
  """
  spec.homepage      = "https://github.com/jdeen/xkpassword"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

	spec.add_dependency "artii", "~> 2.1"
  spec.add_development_dependency "bundler",  "~> 1.12"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "~> 3.5"
end
