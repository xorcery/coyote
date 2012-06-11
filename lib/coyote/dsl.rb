require 'coyote'

module Coyote
  class DSL
    attr_accessor :input, :output, :options
    
    def initialize(&block)
      config = Struct.new(:input, :output, :options).new
      config.options = {}
      yield config if block_given?
      instance_eval(&block)
      @input = config.input
      @output = config.output
      @options = config.options
    end
    
    def run
      Coyote.compile(@input, @output, @options)            
    end
  end
end


def coyote(*args, &block)
  runner = Coyote::DSL.new(&block)
  runner.run
end


