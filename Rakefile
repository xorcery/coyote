require 'rubygems'
require 'rbconfig'
require 'rake'
require 'echoe'

$: << File.expand_path(File.dirname(__FILE__) + "/lib")
require 'coyote'

task :default => :spec

task :spec do
  sh "rspec ."
end

Echoe.new('coyote', Coyote::VERSION) do |p|
  p.description    = "A speedy tool for combining and compressing your JavaScript, CoffeeScript, CSS and LESS source files."
  p.summary        = "Coyote combines your source files into a single script or stylesheet to reduce HTTP overhead and make development easier. It has built-in support for Sprockets-style dependency syntax (`#= require x`) and a lightning-fast, built-in watch mechanism to detect changes to your source files and recompile on the fly. For increased optimization, you can optionally run the final compilation through the Google Closure Compiler before save."
  p.url            = "http://github.com/imulus/coyote"
  p.author         = "Imulus"
  p.email          = "developer@imulus.com"
  p.ignore_pattern = ["./spec/*", "./tmp/*", "./test/*"]

  dependencies = Array.new
  target_os = Config::CONFIG['target_os']

  if target_os =~ /darwin/i
    dependencies << "rb-fsevent >=0.4.0"
    dependencies << "colored >=1.2"
  elsif target_os =~ /linux/i
    dependencies << "rb-inotify >=0.8.4"
  elsif target_os =~ /mswin|mingw/i
    dependencies << "rb-fchange >=0.0.5"
  end
  
  p.development_dependencies = dependencies
  p.runtime_dependencies = dependencies
end

task :build do
  `rake manifest`
  `rake build_gemspec`
  `gem build coyote.gemspec`
end




