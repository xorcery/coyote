require 'rubygems'
require 'rake'
require 'echoe'

$: << File.expand_path(File.dirname(__FILE__) + "/lib")
require 'coyote'

Echoe.new(Coyote::APP_NAME.downcase, Coyote::VERSION) do |p|
  p.description    = "An intelligent command-line tool for combining and compressing JavaScript files."
	p.summary 			 = "Coyote selectively concatenates your JS files, combining them into a single file with the option of running the output through the Google Closure Compiler. Coyote automatically observes your directories and source files for changes and will recompile and save on the fly for easy development."
  p.url            = "http://github.com/imulus/coyote"
  p.author         = "Imulus"
  p.email          = "developer@imulus.com"
  p.ignore_pattern = ["tmp/*", "script/*", "test/*"]
  p.development_dependencies = ["term-ansicolor >=1.0.5", "rb-appscript >=0.6.1"]
	p.runtime_dependencies = ["term-ansicolor >=1.0.5", "rb-appscript >=0.6.1"]
end