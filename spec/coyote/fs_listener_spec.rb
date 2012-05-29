require 'spec_helper'
require 'coyote/fs_listener'

describe Coyote::FSListener do
  
  context ".choose" do
    it "returns a Darwin FSListener when on a mac" do
      Config::CONFIG['target_os'] = 'darwin'
      Coyote::Darwin.stub(:usable?) { true }
      Coyote::Darwin.should_receive :new
      Coyote::FSListener.choose
    end
    
    it "returns a Linux FSListener when on Linux" do
      Config::CONFIG['target_os'] = 'linux'
      Coyote::Linux.stub(:usable?) { true }
      Coyote::Linux.should_receive :new
      Coyote::FSListener.choose
    end
    
    it "returns a Windows FSListener when on Windows" do
      ['mswin', 'mingw'].each do |target_os|
        Config::CONFIG['target_os'] = target_os
        Coyote::Windows.stub(:usable?) { true }
        Coyote::Windows.should_receive :new
        Coyote::FSListener.choose
      end
    end  

    it "returns a Polling FSListener when on an any other OS" do
      Config::CONFIG['target_os'] = "asdfasdf"
      Coyote::Polling.should_receive :new
      Coyote::FSListener.choose
    end    
  end
  
  
end