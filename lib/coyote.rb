require 'coyote/runner'

# 1. Get a hash of all files in the manifest in the order they should be compiled

module Coyote
  def self.build(input_path, output_path)
    runner = Coyote::Runner.new(input_path)
    puts runner.files
    # runner.assets.each do |path, asset|
    #   puts path
    # end
  end
end



