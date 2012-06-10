require 'spec_helper'
require 'coyote/assets'

module Coyote::Assets
  describe Less do
    context "compile!" do
      it "compiles the contents" do
        asset = Less.new("spec/assets/assets/less/stylesheet1.less")
        asset.contents.should == `lessc spec/assets/assets/less/stylesheet1.less`
      end
    end
  end
end