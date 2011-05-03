require 'yaml'
require 'term/ansicolor'
include Term::ANSIColor

module Coyote
	VERSION = "0.2.4"
	ROOT_PATH = Dir.pwd
	CONFIG_PATH = File.expand_path(File.dirname(__FILE__) + "/../config")
	CONFIG_FILENAME = "coyote.yaml"
end