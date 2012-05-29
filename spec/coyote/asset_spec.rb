require 'spec_helper'
require 'coyote/asset'

describe Coyote::Asset do
  context "#contents" do
    it "returns the contents of the file" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/script1.js")
      asset.contents.should == IO.read("spec/assets/asset/javascript/script1.js")
    end
  end

  context "#dependencies" do
    it "returns the relative filepaths of its dependencies" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/script3.js")
      asset.dependencies.should include("script4.js")
    end
    
    it "can find files in relative directories" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/script5.js")
      asset.dependencies.should include("scripts/script6.js")      
    end
    
    it "can back out of a directory to find other files" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/scripts/script7.js")
      asset.dependencies.should include("../scripts2/script8.js")      
    end    
  end
  
  context "#update!" do
    it "resets the cache to fall back on lazy loading" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/scripts/script7.js")
      asset.contents
      asset.update!
      asset.instance_variable_get(:@contents).should be_nil
    end
  end
  
end
