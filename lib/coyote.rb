require 'yaml'
require 'term/ansicolor'
require 'coyote/script'
require 'coyote/configuration'
require 'coyote/fs_listener'
require 'coyote/generator'
require 'coyote/closure_compiler'
require 'coyote/notification'

include Term::ANSIColor

module Coyote
  APP_NAME        = "Coyote"
  VERSION         = "0.6.1"
  ROOT_PATH       = Dir.pwd
  CONFIG_PATH     = File.expand_path(File.dirname(__FILE__) + "/../config")
  CONFIG_FILENAME = "coyote.yaml"
  CONFIG_ICON     = "coyote-icon.png"
  USAGE_FILENAME  = "coyote-usage.txt"

  module Defaults
    OUTPUT = "coyote.js"
  end

  def self.generate
    Coyote::Generator.new.generate
  end


  def self.build(config)
    output = Coyote::Script.select_and_init(config.output)
    output.empty!

    config.inputs.each do |file, input|
      output.append input.contents
      print "+ Added #{file}\n" if config.options['verbose']
    end

    output.compress! if config.should_compress?
    output.save
    Coyote::Notification.new "Saved #{config.output}\n\n", "success"
  end


  def self.watch(config)
    self.build config

    listener = Coyote::FSListener.select_and_init

    listener.on_change do |files|
      if files.include? config.source
        Coyote::Notification.new "Config file (#{config.source}) changed. Reading it in.\n", "warning"
        config.load_from_yaml! config.source
        self.build config
      else
        changed_watched_files = config.inputs & files
        if changed_watched_files.length > 0
          self.build config
        end
      end
    end

    listener.start
  end


  def self.usage
    file = File.open("#{Coyote::CONFIG_PATH}/#{Coyote::USAGE_FILENAME}", 'r')
    puts file.read
    file.close
  end
end