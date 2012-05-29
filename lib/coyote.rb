require 'coyote/version'
require 'coyote/compiler'

module Coyote
  
  def self.compile(input, output, options)
    Compiler.new(input, output).compile!
  end

end