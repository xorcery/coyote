require 'yaml'
require 'term/ansicolor'
require 'coyote/config_reader'
require 'coyote/fs_listener'
require 'coyote/generator'
require 'coyote/output'
require 'coyote/closure_compiler'
require 'coyote/notification'

include Term::ANSIColor

module Coyote
	APP_NAME = "Coyote"
	VERSION = "0.3.0"
	ROOT_PATH = Dir.pwd
	CONFIG_PATH = File.expand_path(File.dirname(__FILE__) + "/../config")
	CONFIG_FILENAME = "coyote.yaml"
	CONFIG_ICON = "coyote-icon.png"
end