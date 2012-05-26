require 'coyote/bundle'
require 'coyote/fs_listener'

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
      listener = Coyote::FSListener.choose

      listener.on_change do |changed_files|
        changed_files = @bundle.files & changed_files.map {|file| File.expand_path file }

        if changed_files.length > 0
          @bundle.update! changed_files
          save!
        end
      end

      listener.start
    end

  
  end
end