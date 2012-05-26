require 'coyote/compiler'

module Coyote
  
  def self.compile(input, output)
    Compiler.new(input, output).compile!
  end

end