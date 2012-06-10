require 'spec_helper'
require 'coyote/bundles'

module Coyote::Bundles
  describe JavaScript do

    it "only allows whitelisted dependency filetypes" do
      bundle = JavaScript.new 'spec/assets/bundles/javascript/output.js'
      input1 = File.expand_path 'spec/assets/bundles/javascript/script1.js'
      input2 = File.expand_path 'spec/assets/bundles/css/weird_file.asdf'
      bundle.add(input1)
      bundle.add(input2)
      bundle.files.should_not include(input2)
    end
    
  end
end
