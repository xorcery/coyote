require 'coyote/asset'

describe Coyote::Asset do
  context "#contents" do
    it "returns the contents of the file" do
      asset = Coyote::Asset.new("spec/assets/script1.js")
      asset.contents.should == IO.read("spec/assets/script1.js")
    end
  end

  context "#dependencies" do
    it "returns the relative filepaths of its dependencies" do
      asset = Coyote::Asset.new("spec/assets/script3.js")
      asset.dependencies.should include("script4.js")
    end
    
    it "can find files in relative directories" do
      asset = Coyote::Asset.new("spec/assets/script5.js")
      asset.dependencies.should include("scripts/script6.js")      
    end
    
    it "can back out of a directory to find other files" do
      asset = Coyote::Asset.new("spec/assets/scripts/script7.js")
      asset.dependencies.should include("../scripts2/script8.js")      
    end    
  end
end
