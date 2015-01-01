# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'memopri/version'

Gem::Specification.new do |spec|
  spec.name          = "memopri"
  spec.version       = Memopri::VERSION
  spec.authors       = ["Hiroyuki Ikegami"]
  spec.email         = ["ikegam@mixallow.net"]
  spec.summary       = %q{Client software for CASIO Memopri MEP-F10}
  spec.description   = %q{Client software for CASIO Memopri MEP-F10}
  spec.homepage      = "https://github.com/ikegam/memopri"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.executables << 'memopri'

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "cairo"
  spec.add_dependency "pango"
end
