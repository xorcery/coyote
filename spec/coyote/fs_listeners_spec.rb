require 'spec_helper'
require 'coyote/fs_listeners'


module Coyote
  describe FSListener do
    context ".new" do
      it "returns a Darwin FSListener when on a mac" do
        RbConfig::CONFIG['target_os'] = 'darwin'
        FSListeners::Darwin.stub(:usable?) { true }
        FSListeners::Darwin.should_receive :new
        FSListener.new
      end
    
      it "returns a Linux FSListener when on Linux" do
        RbConfig::CONFIG['target_os'] = 'linux'
        FSListeners::Linux.stub(:usable?) { true }
        FSListeners::Linux.should_receive :new
        FSListener.new
      end
    
      it "returns a Windows FSListener when on Windows" do
        ['mswin', 'mingw'].each do |target_os|
          RbConfig::CONFIG['target_os'] = target_os
          FSListeners::Windows.stub(:usable?) { true }
          FSListeners::Windows.should_receive :new
          FSListener.new
        end
      end  
    
      it "returns a Polling FSListener when on an any other OS" do
        RbConfig::CONFIG['target_os'] = "asdfasdf"
        FSListeners::Polling.should_receive :new
        FSListener.new
      end    
    end
  end
end
