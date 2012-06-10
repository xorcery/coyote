require 'spec_helper'
require 'coyote/assets/coffeescript'

module Coyote::Assets
  describe CoffeeScript do
    context "#dependencies" do
      it "finds dependencies" do
        asset = CoffeeScript.new("spec/assets/assets/coffeescript/script1.coffee")
        asset.dependencies.should include("script2.coffee", "script3.js")
      end
    end

    context "compile!" do
      it "compiles the contents" do
        asset = CoffeeScript.new("spec/assets/assets/coffeescript/script4.coffee")
        asset.contents.should == `cat spec/assets/assets/coffeescript/script4.coffee | coffee -sc`
      end
    end

  end
end