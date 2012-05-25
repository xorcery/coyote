require 'coyote/compiler'

module Coyote
  
  def self.compile(input, output)
    compiler = Compiler.new(input)
    compiler.save output
  end

end