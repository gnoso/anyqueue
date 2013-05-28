# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'anyqueue/version'

Gem::Specification.new do |spec|
  spec.name          = "anyqueue"
  spec.version       = Anyqueue::VERSION
  spec.authors       = ["Alan Johnson", "Taylor Shuler"]
  spec.email         = ["alan@gnoso.com", "taylorshuler@aol.com"]
  spec.description   = %q{AnyQueue is a queue abstraction layer.}
  spec.summary       = %q{A queue abstraction layer.}
  spec.homepage      = "https://github.com/gnoso/anyqueue"
  spec.license       = "Apache License 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "echoe"
  spec.add_dependency "uuidtools", ">= 1.0.4"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
