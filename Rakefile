require 'rubygems'
require 'rbconfig'
require 'rake'
require 'echoe'

$: << File.expand_path(File.dirname(__FILE__) + "/lib")
require 'coyote'

Echoe.new(Coyote::APP_NAME.downcase, Coyote::VERSION) do |p|
  p.description    = "An intelligent command-line tool for combining, compressing and compiling your JavaScript and CoffeeScript files."
	p.summary 			 = "Coyote selectively concatenates your files, combining them into a single file with the option of running the output through the Google Closure Compiler before save. It can be used to observe your source files for changes and will recompile and save on the fly for easy development."
		
  p.url            = "http://github.com/imulus/coyote"
  p.author         = "Imulus"
  p.email          = "developer@imulus.com"
  p.ignore_pattern = ["tmp/*", "script/*", "test/*", "assets/*"]
  
  dependencies = Array.new
  dependencies << "term-ansicolor >=1.0.5"
  target_os = Config::CONFIG['target_os']
  
  if target_os =~ /darwin/i
    dependencies << "rb-fsevent >=0.4.0"
    dependencies << "rb-appscript >=0.6.1"
  elsif target_os =~ /linux/i
    dependencies << "rb-inotify >=0.8.4"
  elsif target_os =~ /mswin|mingw/i
    dependencies << "rb-fchange >=0.0.5"
  end
  
  p.development_dependencies = dependencies
	p.runtime_dependencies = dependencies
end