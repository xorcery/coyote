module Coyote
  autoload :JavaScript,  		'coyote/scripts/javascript'
  autoload :CoffeeScript, 	'coyote/scripts/coffeescript'
  autoload :Combine, 				'coyote/scripts/combine'

  class Script
    attr_accessor :filename, :contents


    def self.select_and_init(filename)
      case File.extname(filename)
      when /\.js/i			; JavaScript.new(filename)
      when /\.coffee/i	; CoffeeScript.new(filename)
      when /\.combine/i	; Combine.new(filename)	
      else							; self.new(filename)
      end
    end


    def initialize(filename, contents = "")
      @filename = filename
      @directory = File.dirname(@filename)

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


    def require_pattern
      Regexp.new(/\/\/=\s*require\s*(.*)$/i)
    end


    def requires
      matches = @contents.scan(require_pattern)
      matches.collect do |match|
				File.expand_path(match.last.strip, @directory)
      end
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


    def save
      output = File.open @filename, 'w+'
      output.write @contents
      output.close
    end


  end
end


