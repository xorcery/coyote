# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "coyote"

Gem::Specification.new do |s|
  s.name        = "coyote"
  s.version     = Coyote::VERSION
  s.authors     = ["Imulus","Casey O'Hara"]
  s.email       = ["developer@imulus.com","casey.ohara@imulus.com"]
  s.homepage    = "http://github.com/imulus/coyote"
  s.summary     = "Coyote combines your source files into a single script or stylesheet to reduce HTTP overhead and make development easier. It has built-in support for Sprockets-style dependency syntax (`#= require x`) and a lightning-fast, built-in watch mechanism to detect changes to your source files and recompile on the fly. For increased optimization, you can optionally run the final compilation through the Google Closure Compiler before save."
  s.description = "A speedy tool for combining and compressing your JavaScript, CoffeeScript, CSS and LESS source files."

  s.rubyforge_project = "coyote"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency(%q<rb-fsevent>, [">= 0.4.0"])
  s.add_runtime_dependency(%q<colored>, [">= 1.2"])
  s.add_development_dependency(%q<rb-fsevent>, [">= 0.4.0"])
  s.add_development_dependency(%q<colored>, [">= 1.2"])
end
