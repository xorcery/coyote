require 'spec_helper'
require 'coyote/bundles'

module Coyote::Bundles
  describe CSS do

    it "only allows whitelisted dependency filetypes" do
      bundle = CSS.new 'spec/assets/bundles/css/output.css'
      input1 = File.expand_path 'spec/assets/bundles/css/stylesheet1.css'
      input2 = File.expand_path 'spec/assets/bundles/css/weird_file.asdf'
      bundle.add(input1)
      bundle.add(input2)
      bundle.files.should_not include(input2)
    end
    
  end
end
