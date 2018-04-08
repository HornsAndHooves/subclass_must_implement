# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lazy_object'

Gem::Specification.new do |spec|
  spec.name          = "subclass_must_implement"
  spec.version       = SubclassMustImplement.version
  spec.authors       = ["Arthur Shagall"]
  spec.email         = ["arthur.shagall@gmail.com"]
  spec.summary       = %q{Make abstract methods explicit.}
  spec.description   = %q{Auto-generate abstract method stubs to mark them as required to be implemented in subclasses.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
