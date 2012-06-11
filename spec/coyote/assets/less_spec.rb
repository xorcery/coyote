require 'spec_helper'
require 'coyote/assets'

module Coyote::Assets
  describe Less do
    context "compile!" do
      it "compiles the contents" do
        asset = Less.new("spec/assets/assets/less/stylesheet1.less")
        asset.compile!
        asset.contents.should == `lessc spec/assets/assets/less/stylesheet1.less`
      end
    end
    
    context "#dependencies" do
      it "finds dependencies" do
        asset = Less.new("spec/assets/assets/less/stylesheet2.less")
        asset.dependencies.should include("stylesheet3.less", "stylesheet4.less", "stylesheet5.css")
      end
    end    
    
  end
end