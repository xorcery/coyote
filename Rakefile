require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('coyote', '0.2.3') do |p|
  p.description    = "A command-line tool for combining and compressing JS files"
	p.summary 			 = "Coyote is a command-line tool for combining and compressing JS files. It uses YAML for configuration and the Google Closure Compiler to compilation and compression."
  p.url            = "http://github.com/caseyohara/coyote"
  p.author         = "Casey O'Hara"
  p.email          = "casey.ohara@imulus.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.development_dependencies = ["closure-compiler >=1.1.1", "term-ansicolor >=1.0.5"]
	p.runtime_dependencies = ["closure-compiler >=1.1.1", "term-ansicolor >=1.0.5"]
end