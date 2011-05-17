module Coyote
  class Darwin < FSListener
    attr_reader :fsevent

    def initialize
      super
      @fsevent = FSEvent.new
    end

    def on_change(&callback)
      @fsevent.watch [Dir.pwd] do |modified_dirs|
        files = modified_files(modified_dirs)
        update_last_event
        callback.call(files)
      end
    end

    def start
      @fsevent.run
    end

    def stop
      @fsevent.stop
    end

    def self.usable?
      require 'rb-fsevent'
      if !defined?(FSEvent::VERSION) || Gem::Version.new(FSEvent::VERSION) < Gem::Version.new('0.3.9')
        print "Please update rb-fsevent (>= 0.3.9)\n".red
        false
      else
        true
      end
    rescue LoadError
      print "Please install rb-fsevent gem for Mac OSX FSEvents support\n".red
      false
    end

  end
end
