require 'spec_helper'
require 'coyote/bundles/base'

module Coyote::Bundles
  
  describe Base do

    let(:bundle) { Base.new('spec/assets/bundles/base/output.js') }

    context "#add" do
      it "adds an input to the bundle" do
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.files.should include File.expand_path("spec/assets/bundles/base/script1.js")
      end
    
      it "adds an input's dependencies" do
        bundle.add("spec/assets/bundles/base/script3.js")      
        bundle.files.should include File.expand_path("spec/assets/bundles/base/script3.js")
        bundle.files.should include File.expand_path("spec/assets/bundles/base/script4.js")
      end
    
      it "doesn't add the same dependency twice" do
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.files.length.should == 1
      end
    
      it "arranges dependencies in the right order" do
        input1 = File.expand_path "spec/assets/bundles/base/script5.js"
        input2 = File.expand_path "spec/assets/bundles/base/script6.js"
        dependency1 = File.expand_path "spec/assets/bundles/base/jquery.js"
        bundle.add(input1)
        bundle.add(input2)
        bundle.files.should == [input1, input2, dependency1]
      end

      it "only adds file that exist" do
        bundle.add("spec/assets/bundles/base/does_not_exist.js")
        bundle.files.should == []
      end
      
      it "can recursively add a directory" do
        nested_script1 = File.expand_path "spec/assets/bundles/base/directory1/directory1_script.js"
        nested_script2 = File.expand_path "spec/assets/bundles/base/directory1/directory2/directory2_script.js"
        bundle.add("spec/assets/bundles/base/directory1")
        bundle.files.should == [nested_script1, nested_script2]
      end      
    end
  
    context "#files" do
      it "has fullpaths to the files" do
        input1 = File.expand_path "spec/assets/bundles/base/script1.js"
        input2 = File.expand_path "spec/assets/bundles/base/script2.js"
        bundle.add(input1)
        bundle.add(input2)
        bundle.files.should == [input1, input2]
      end
    end
  
    context "#empty!" do
      it "removes all of its files" do
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.empty!
        bundle.files.should be_empty
      end
    
      it "removes all of the bundle's contents" do
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.empty!
        bundle.contents.should be_empty
      end
    end

    context "#contents" do
      it "returns the contents of all of its assets in the right order" do
        input1 = File.expand_path "spec/assets/bundles/base/script5.js"
        input2 = File.expand_path "spec/assets/bundles/base/script6.js"
        dependency1 = File.expand_path "spec/assets/bundles/base/jquery.js"
        bundle.add(input1)
        bundle.add(input2)
        contents = IO.read(dependency1) + IO.read(input2) + IO.read(input1)
        bundle.contents.should == contents
      end    
    end

    context "#update!" do
      it "tells the changed files's assets to update" do
        input = "spec/assets/bundles/base/script1.js"
        bundle.add(input)
        bundle.assets[File.expand_path(input)].should_receive(:update!)
        bundle.update!([File.expand_path(input)])
      end

      it "resets the cache" do
        bundle.should_receive(:reset!)
        bundle.update!
      end    
    end

    context "#reset!" do
      it "sets the @contents ivar to nil to reset the memoization in #contents" do
        bundle.add("spec/assets/bundles/base/script1.js")
        bundle.contents
        bundle.reset!
        bundle.instance_variable_get(:@contents).should be_nil
      end
    end
    
    
    context "#save!" do
      it "saves the bundle contents to disk" do
        File.delete(bundle.target) if File.exist? bundle.target
        bundle.add("spec/assets/bundles/base/script5.js")
        bundle.save!
        IO.read(bundle.target).should == bundle.contents      
      end    
    end
    
  end
end
