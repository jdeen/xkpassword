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
    Have you been interested in XKCD Password Generator as seen on http://xkpasswd.net? I was, looked
    arround but found no lib that did the job. So this is my take on the probelm. Hopefully useful to
    you guys. Comments and suggestions are appreciated.
  """
  spec.homepage      = "https://github.com/jdeen/xkpassword"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

	spec.add_dependency "artii", "~> 2.1.1"
  spec.add_development_dependency "bundler",  "~> 1.12"
  spec.add_development_dependency "rake",     "~> 10.0"
  spec.add_development_dependency "rspec",    "~> 3.5.0"
end
