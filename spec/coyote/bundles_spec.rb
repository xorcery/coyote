require 'spec_helper'
require 'coyote/bundles'

module Coyote
  describe Bundle do

     context ".new" do
        it "returns an instance of JavaScript when the output target is .js" do
          Bundle.new("spec/assets/bundle/script.js").should be_an_instance_of Bundles::JavaScript
        end

        it "returns an instance of CSS when the output target is .css" do
          Bundle.new("spec/assets/bundle/stylesheet.css").should be_an_instance_of Bundles::CSS
        end

        it "returns an instance of the Bundle base class when it's an unknown target filetype" do
          Bundle.new("spec/assets/bundle/weird.asdf").should be_an_instance_of Bundles::Base
        end    
      end
  
  end  
end




