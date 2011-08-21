require 'yaml'
require 'term/ansicolor'
require 'coyote/coy_file'
require 'coyote/configuration'
require 'coyote/fs_listener'
require 'coyote/generator'
require 'coyote/output'
require 'coyote/closure_compiler'
require 'coyote/notification'

include Term::ANSIColor

module Coyote
	APP_NAME        = "Coyote"
	VERSION         = "0.4.2"
	ROOT_PATH       = Dir.pwd
	CONFIG_PATH     = File.expand_path(File.dirname(__FILE__) + "/../config")
	CONFIG_FILENAME = "coyote.yaml"
	CONFIG_ICON     = "coyote-icon.png"
  USAGE_FILENAME 	= "coyote-usage.txt"

  module Defaults
    OUTPUT = "coyote.js"
  end

  module CoffeeScript
    EXTENSION = ".coffee"
    COMMENT = "#"
  end

  module JavaScript
    EXTENSION = ".js"
    COMMENT = "//"
  end

	def self.generate
    Coyote::Generator.new.generate
	end

  def self.build(config)
    output = Coyote::CoyFile.new(config.output)
    output.empty!

    config.inputs.each do |file|
      input = Coyote::CoyFile.new file
      input.compile! if input.coffee?
      output.append input.contents
    end

    output.compress! if config.should_compress?
    output.save
  end

	def self.watch(options)
		puts options
	end

	def self.usage
	  file = File.open("#{Coyote::CONFIG_PATH}/#{Coyote::USAGE_FILENAME}", 'r')
		puts file.read
		file.close
	end
end