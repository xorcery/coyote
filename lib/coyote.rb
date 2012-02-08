require 'coyote/bundle'

# 1. Get a hash of all files in the manifest in the order they should be compiled

module Coyote
  def self.build(input_path, output_path)
    bundle = Coyote::Bundle.new(input_path)
    puts bundle.files
    # bundle.assets.each do |path, asset|
    #   puts path
    # end
  end
end



