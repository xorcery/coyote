require 'spec_helper'
require 'coyote/asset'

describe Coyote::Asset do

  context ".choose" do
    it "returns an instance of JavaScript when it's a .js filename" do
      Coyote::Asset.choose("script.js").should be_an_instance_of Coyote::JavaScript
    end
    
    it "returns an instance of CoffeeScript when it's a .coffee filename" do
      Coyote::Asset.choose("script.coffee").should be_an_instance_of Coyote::CoffeeScript
    end

    it "returns an instance of Less when it's a .less filename" do
      Coyote::Asset.choose("stylesheet.less").should be_an_instance_of Coyote::Less
    end
    
    it "returns an instance of Asset (self) when it's an unknown filename" do
      Coyote::Asset.choose("weird.asdf").should be_an_instance_of Coyote::Asset
    end    
  end

  context "#path" do
    it "is the full path to the file" do
      asset = Coyote::Asset.new("spec/assets/asset/javascript/script1.js")
      asset.path.should == File.expand_path("spec/assets/asset/javascript/script1.js")
    end
  end

  context "#relative_path" do
    it "is the path to the file relative from the process" do
      asset = Coyote::Asset.new("spec/../spec/assets/asset/javascript/script1.js")
      asset.relative_path.should == "spec/assets/asset/javascript/script1.js"
    end
  end
  
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
