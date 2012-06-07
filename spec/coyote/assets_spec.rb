require 'spec_helper'
require 'coyote/assets'


module Coyote
  describe Coyote::Asset do

    context ".new" do
      it "returns an instance of JavaScript when it's a .js filename" do
        Asset.new("script.js").should be_an_instance_of Assets::JavaScript
      end
  
      it "returns an instance of CoffeeScript when it's a .coffee filename" do
        Asset.new("script.coffee").should be_an_instance_of Assets::CoffeeScript
      end

      it "returns an instance of Less when it's a .less filename" do
        Asset.new("stylesheet.less").should be_an_instance_of Assets::Less
      end
  
      it "returns an instance of the Asset base class when it's an unknown filename" do
        Asset.new("weird.asdf").should be_an_instance_of Assets::Base
      end    
    end

  end
end