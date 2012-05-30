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
      watch if @options.fetch(:watch, false)
    end

   
    def save!
      File.open @output, 'w+' do |file|
        file.write @bundle.contents
      end
      notify "Saved bundle to #{@output}   [#{@bundle.files.length} files]", :timestamp, :success
    end
    
    
    def watch
      listener = Coyote::FSListener.choose

      listener.on_change do |changed_files|
        changed_files = @bundle.files & changed_files.map {|file| File.expand_path file }

        if changed_files.length > 0
          notify "Detected change, recompiling...", :warning, :timestamp
          @bundle.update! changed_files
          save!
        end
      end

      notify "Watching for changes to your bundle. ctrl+c to stop.", :timestamp
      listener.start
    end
  end
end