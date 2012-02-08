require 'coyote/bundle'

# 1. Get a hash of all files in the manifest in the order they should be compiled

module Coyote
  def self.build(input_path, output_path)
    bundle = Coyote::Bundle.new(input_path)
    bundle.compress!

    output = File.open output_path, 'w+'
    output.write bundle.contents
    output.close
    puts "Saved #{output_path}"

  end
end



