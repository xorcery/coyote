require  "rexml/document"

module Coyote
  class Output

    attr_accessor :input, :input_files, :output_file, :output_filename, :compress, :hooks

    def initialize(output_filename, compress = false, hooks)
      @output_filename = output_filename
      @output_file = File.open(@output_filename, 'w+')
      @input_files = []
      @input = ""
      @compress = compress
      @hooks = Coyote::Hooks.new(hooks)
      print "\n----- Creating #{@output_filename}\n".bold
    end

    def add_files(files)
      files.each do |file|
        append(file)
      end
    end

    # open file, add contents to output
    def append(filename)
      if File.exists?(filename) and ! @input_files.include?(filename)
        @input_files.push(filename)
        File.open(filename, 'r') do |file|
          # @input += "/***** #{filename} *****/\n"
        	@input += file.read
         	@input += "\n\n\n"
        end
        print "+ Added #{filename}\n"
      else
        Coyote::Notification.new "! Error adding #{filename}\n", "failure"
      end
    end

    # save output to file
    def save
      # add_file_comments
      @hooks.invoke('before_compress')
      compress if @compress
      @hooks.invoke('after_compress')
      @hooks.invoke('before_save')
      @output_file.write(@input)
      @output_file.close
      Coyote::Notification.new "Successfully saved to #{@output_filename}\n", "success"
      @hooks.invoke('after_save')
    end

    def add_file_comments
      file_comments = "// Compressed using Coyote\n\n// Files included:\n"
      @input_files.each do |file|
        file_comments += "// #{file}\n"
      end
      file_comments += "\n\n\n"
      @input = file_comments + @input
    end

    # compress output
    def compress
      Coyote::Notification.new "Compiling #{@output_filename}...\n", "warning"

      compiler = ClosureCompiler.new.compile(@input)
      if compiler.success?
        @input = compiler.compiled_code
        add_file_comments
      elsif compiler.file_too_big?
        Coyote::Notification.new "Input code too big for API, creating uncompiled file\n", "failure"
      elsif compiler.errors
        Coyote::Notification.new "Google closure API failed to compile, creating uncompiled file\n", "failure"
        Coyote::Notification.new "Errors: \n", "failure"
        Coyote::Notification.new "#{compiler.errors.to_s}\n\n", "failure"
      end
    end
  end
end


