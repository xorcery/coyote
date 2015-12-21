# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coyote/version'

Gem::Specification.new do |spec|
  spec.name        = "coyote"
  spec.version     = Coyote::VERSION
  spec.authors     = ["Imulus","Casey O'Hara"]
  spec.email       = ["developer@imulus.com","casey.ohara@imulus.com"]
  spec.homepage    = "http://github.com/imulus/coyote"
  spec.summary     = "Coyote combines your source files into a single script or stylesheet to reduce HTTP overhead and make development easier. It has built-in support for Sprockets-style dependency syntax (`#= require x`) and a lightning-fast, built-in watch mechanism to detect changes to your source files and recompile on the fly. For increased optimization, you can optionally run the final compilation through the Google Closure Compiler before save."
  spec.description = "A speedy tool for combining and compressing your JavaScript, CoffeeScript, CSS and LESS source files."

  spec.rubyforge_project = "coyote"

  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # specify any dependencies here; for example:
  spec.add_runtime_dependency 'rb-fsevent', '>= 0.4.0'
  spec.add_runtime_dependency 'colored', '>= 1.2'

  spec.add_development_dependency 'rspec', '~> 2.10.0'
  spec.add_development_dependency 'guard', '~> 1.0.3'
  spec.add_development_dependency 'guard-rspec', '~> 0.7.3'
  spec.add_development_dependency 'simplecov', '~> 0.6.4'
  spec.add_development_dependency 'growl', '~> 1.0.3'
  spec.add_development_dependency 'rake', '0.9.2.2'
end
