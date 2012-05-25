require 'coyote/bundle'

module Coyote
  class Compiler
    attr_reader :bundle

    def initialize(input)
      @bundle = Coyote::Bundle.new
      @bundle.add(input)
    end

   
    def save(output_path)
      File.open output_path, 'w+' do |file|
        file.write @bundle.contents
      end
    end
  end
end