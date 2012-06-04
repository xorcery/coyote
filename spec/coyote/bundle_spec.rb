require 'spec_helper'
require 'coyote/bundle'

describe Coyote::Bundle do

  let(:bundle) { Coyote::Bundle.new }

  context "#add" do
    it "adds an input to the bundle" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.assets.should have_key File.expand_path("spec/assets/bundle/javascript/script1.js")
    end
    
    it "adds an input's dependencies" do
      bundle.add("spec/assets/bundle/javascript/script3.js")      
      bundle.assets.should have_key File.expand_path("spec/assets/bundle/javascript/script3.js")
      bundle.assets.should have_key File.expand_path("spec/assets/bundle/javascript/script4.js")
    end
    
    it "doesn't add the same dependency twice" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.assets.length.should == 1
    end
    
    it "arranges dependencies in the right order" do
      input1 = File.expand_path "spec/assets/bundle/javascript/script5.js"
      input2 = File.expand_path "spec/assets/bundle/javascript/script6.js"
      dependency1 = File.expand_path "spec/assets/bundle/javascript/jquery.js"
      bundle.add(input1)
      bundle.add(input2)
      bundle.files.should == [input1, input2, dependency1]
    end
  end
  
  context "#files" do
    it "has fullpaths to the files" do
      input1 = File.expand_path "spec/assets/bundle/javascript/script1.js"
      input2 = File.expand_path "spec/assets/bundle/javascript/script2.js"
      bundle.add(input1)
      bundle.add(input2)
      bundle.files.should == [input1, input2]
    end
  end
  
  context "#empty!" do
    it "removes all of its assets" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.empty!
      bundle.assets.should be_empty
    end
    
    it "removes all of the bundle's contents" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.empty!
      bundle.contents.should be_empty
    end
  end

  context "#contents" do
    it "returns the contents of all of its assets" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.add("spec/assets/bundle/javascript/script2.js")
      contents = IO.read("spec/assets/bundle/javascript/script1.js") + IO.read("spec/assets/bundle/javascript/script2.js")
      bundle.contents.should == contents
    end
  end

  context "#update!" do
    it "tells the changed files's assets to update" do
      input1 = "spec/assets/bundle/javascript/script1.js"
      input2 = "spec/assets/bundle/javascript/script2.js"
      bundle.add(input1)
      bundle.add(input2)
      bundle.assets[File.expand_path(input1)].should_receive(:update!)
      bundle.assets[File.expand_path(input2)].should_receive(:update!)
      bundle.update!([File.expand_path(input1),File.expand_path(input2)])
    end

    it "resets the cache" do
      bundle.should_receive(:reset!)
      bundle.update!
    end    
  end

  context "#reset!" do
    it "sets the @contents ivar to nil to reset the memoization in #contents" do
      bundle.add("spec/assets/bundle/javascript/script1.js")
      bundle.contents
      bundle.reset!
      bundle.instance_variable_get(:@contents).should be_nil
    end
  end
  
  
end




