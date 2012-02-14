module Coyote
  class Configuration
    attr_accessor :input, :output, :options

    def initialize 
      @input = ""; @output = "";  @options = {}
    end    
  end
end


def coyote(method, &block)
  config = Coyote::Configuration.new
  yield config
  
  if config.input.empty?
    notify "Coyote: Input filepath must be defined", :failure
    exit 0
  end

  if config.output.empty?
    notify "Coyote: Output filepath must be defined", :failure
    exit 0
  end
  
  if method == :watch
    config.options[:watch] = true 
  end
  
  Coyote::run config.input, config.output, config.options
end
