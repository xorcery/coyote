require 'rubygems'
require 'rake'

$: << File.expand_path(File.dirname(__FILE__) + "/lib")
require 'coyote'

task :default => :spec

task :spec do
  sh "rspec ."
end