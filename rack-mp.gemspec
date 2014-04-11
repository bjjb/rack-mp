# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/mp/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-mp"
  spec.version       = Rack::MP::VERSION
  spec.authors       = ["JJ Buckley"]
  spec.email         = ["jj@bjjb.org"]
  spec.summary       = %q{Rack Memory Profiler}
  spec.description   = %q{Helps analyse memory usage in your Rack apps}
  spec.homepage      = "http://bjjb.github.io/rack-mp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_dependency "rack" # obviously
  spec.add_dependency "multi_json" # chooses the fastest JSON available
  spec.add_dependency "hipsterhash" # faster than an OpenStruct
end
