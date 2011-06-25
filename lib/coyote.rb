require 'yaml'
require 'term/ansicolor'
require 'coyote/config_reader'
require 'coyote/fs_listener'
require 'coyote/generator'
require 'coyote/output'
require 'coyote/closure_compiler'
require 'coyote/notification'
require 'coyote/hooks'

include Term::ANSIColor

module Coyote
	APP_NAME = "Coyote"
	VERSION = "0.4.1"
	ROOT_PATH = Dir.pwd
	CONFIG_PATH = File.expand_path(File.dirname(__FILE__) + "/../config")
	CONFIG_FILENAME = "coyote.yaml"
	CONFIG_ICON = "coyote-icon.png"
end