module Coyote
  class Script
		attr_accessor :filename, :contents

		def initialize(filename, contents = "")
		  @filename = filename
      if contents.empty? and File.exists? @filename
        @contents = File.open(@filename, 'r').read
		  else
		    @contents = contents
		  end
		end

		def append(content)
		  @contents += "#{content}\n\n"
		end

		def prepend(content)
		  @contents = "#{content}\n\n" + @contents
		end

    def type
      File.extname @filename
    end

    def coffee?
      type == Coyote::CoffeeScript::EXTENSION
    end

    def javascript?
      type == Coyote::JavaScript::EXTENSION
    end
		
		def requires
			pattern = Regexp.new(/((\/\/|\#)=.*)(require )(.*)$/x)
			matches = @contents.scan(pattern)
			matches.collect { |match| match.last.strip }
		end


    def empty!
      @contents = ""
    end

		def compress!
      Coyote::Notification.new "Compiling #{@filename}...\n", "warning"
      compiler = ClosureCompiler.new.compile(@contents)
      if compiler.success?
        @contents = compiler.compiled_code
      elsif compiler.file_too_big?
        Coyote::Notification.new "Input code too big for API, creating uncompiled file\n", "failure"
      elsif compiler.errors
        Coyote::Notification.new "Google closure API failed to compile, creating uncompiled file\n", "failure"
        Coyote::Notification.new "Errors: \n", "failure"
        Coyote::Notification.new "#{compiler.errors.to_s}\n\n", "failure"
      end
		end

    def compile!
      @contents = `cat #{@filename} | coffee -scb`
    end

		def save
      output = File.open @filename, 'w+'
      output.write @contents
      output.close
		end
	end
end


