require 'coyote/fs_listeners/base'
require 'coyote/fs_listeners/darwin'
require 'coyote/fs_listeners/linux'
require 'coyote/fs_listeners/windows'
require 'coyote/fs_listeners/polling'


module Coyote

  module FSListener
    def self.new
      Coyote::FSListeners.choose
    end
  end

  module FSListeners
    def self.choose
      if mac? && Darwin.usable?
        Darwin.new
      elsif linux? && Linux.usable?
        Linux.new
      elsif windows? && Windows.usable?
        Windows.new
      else
        notify "Using polling (Please help us to support your system better than that.)", :failure
        Polling.new
      end
    end
  
    def self.mac?
      RbConfig::CONFIG['target_os'] =~ /darwin/i
    end
  
    def self.linux?
      RbConfig::CONFIG['target_os'] =~ /linux/i
    end
  
    def self.windows?
      RbConfig::CONFIG['target_os'] =~ /mswin|mingw/i
    end
  end
end
