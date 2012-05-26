require 'coyote/bundle'

module Coyote
  class Compiler
    attr_reader :bundle

    def initialize(input, output, options={})
      @options = options || {}
      @output = output
      @bundle = Coyote::Bundle.new
      @bundle.add(input)
    end
   
    def compile!
      save!
      watch if @options.fetch(:watch, nil)
    end

   
    def save!
      File.open @output, 'w+' do |file|
        file.write @bundle.contents
      end
    end
    
    
    def watch
      
    end

  
  end
end