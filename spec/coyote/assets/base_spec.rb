require 'spec_helper'
require 'coyote/assets/base'

module Coyote::Assets
  
  describe Base do
    context "#path" do
      it "is the full path to the file" do
        asset = Base.new("spec/assets/assets/javascript/script1.js")
        asset.path.should == File.expand_path("spec/assets/assets/javascript/script1.js")
      end
    end

    context "#relative_path" do
      it "is the path to the file relative from the process" do
        asset = Base.new("spec/../spec/assets/assets/javascript/script1.js")
        asset.relative_path.should == "spec/assets/assets/javascript/script1.js"
      end
    end
  
    context "#contents" do
      it "returns the contents of the file" do
        asset = Base.new("spec/assets/assets/javascript/script1.js")
        asset.contents.should == IO.read("spec/assets/assets/javascript/script1.js")
      end
    end

    context "#dependencies" do
      it "returns the relative filepaths of its dependencies" do
        asset = Base.new("spec/assets/assets/javascript/script3.js")
        asset.dependencies.should include("script4.js")
      end
    
      it "can find files in relative directories" do
        asset = Base.new("spec/assets/assets/javascript/script5.js")
        asset.dependencies.should include("scripts/script6.js")      
      end
    
      it "can back out of a directory to find other files" do
        asset = Base.new("spec/assets/assets/javascript/scripts/script7.js")
        asset.dependencies.should include("../scripts2/script8.js")      
      end    
    end
  
    context "#update!" do
      it "reads the file in from disk" do
        asset = Base.new("spec/assets/assets/javascript/scripts/script7.js")
        asset.update!
        asset.contents.should_not be_nil
      end
    end
  end

end