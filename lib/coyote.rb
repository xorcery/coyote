require 'coyote/bundle'

# 1. Get a hash of all files in the manifest in the order they should be compiled

module Coyote
    
  def self.run(input_path, output_path, options = {})
    @@options = options
    bundle = Coyote::Bundle.new(input_path, output_path)
    build bundle
    watch bundle if @@options[:watch]
  end
  
  def self.build(bundle)
    bundle.compress! if @@options[:compress]
    bundle.log unless @@options[:quiet]
    bundle.save
  end

  def self.watch(bundle)
    build bundle
  end

end



