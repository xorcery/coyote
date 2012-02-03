require 'coyote/asset'

module Coyote
  def self.build(input_path, output_path)
    manifest  = Coyote::Asset.new input_path    
    output    = Coyote::Asset.new output_path
    output.contents = manifest.contents
    output.save
  end
end