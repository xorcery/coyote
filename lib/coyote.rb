require 'yaml'
require 'term/ansicolor'
require 'coyote/config_reader'
require 'coyote/fs_listener'
require 'coyote/generator'
require 'coyote/output'
require 'coyote/closure_compiler'

include Term::ANSIColor

module Coyote
	VERSION = "0.2.5"
	ROOT_PATH = Dir.pwd
	CONFIG_PATH = File.expand_path(File.dirname(__FILE__) + "/../config")
	CONFIG_FILENAME = "coyote.yaml"
end