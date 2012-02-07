module Coyote
  autoload :JavaScript,  		'coyote/scripts/javascript'
  autoload :CoffeeScript, 	'coyote/scripts/coffeescript'
  autoload :Combine, 				'coyote/scripts/combine'

  class Script
    attr_reader :filename, :relative_path
    attr_accessor :contents

    # Class method
    # Determine the type of file base on the file extension
    # and return an instance of the proper extended script class
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
      @relative_path = @filename.gsub("#{Dir.pwd}/", '')
      @directory = File.dirname(@filename)

      if contents.empty? and File.exists? @filename
        @contents = File.open(@filename, 'r').read
      else
        @contents = contents
      end
    end


    # Append a string of additional content
    # to the end of the current script contents
    def append(string)
      @contents += "#{string}\n\n"
    end


    # Prepend a string of additional content
    # to the beginning of the current script contents
    def prepend(string)
      @contents = "#{string}\n\n" + @contents
    end


    # Defines the regex pattern for scanning the contents of the
    # file to look for require directives
    def require_pattern
      Regexp.new(/\/\/=\s*require\s*(.*)$/i) # '//= require a/b/c.js' => 'a/b/c.js'
    end


    # Scan the contents of the file for require directives
    # By default, it looks for a directive of '//= require a/b/c.js'
    # It determines the full filepath of the required file,
    # relative to the current file being read in
    def requires(pattern = require_pattern)
      matches = @contents.scan(pattern)
      matches.collect do |match|
        # File.expand_path(match.last.strip, @directory)
        match.last.strip
      end
    end


    # Clear out the contents of the script, in-place
    def empty!
      @contents = ""
    end


    # Run the contents of the script through the Google Closure compile
    # It compresses the contents of the script in-place
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


    # Save the contents of the script to disk
    def save
      output = File.open @filename, 'w+'
      output.write @contents
      output.close
    end



    protected

    # This method converts a JavaScript filepath to a CoffeeScript filepath in the same directory
    # Given the path /a/b/c.js it will return /a/b/c.coffee
    def convert_js_path_to_coffee(path)
      directory, basename = File.split(path)
      basename = File.basename(basename, '.js')
      "#{directory}/#{basename}.coffee"
    end

    # This method converts a CoffeeScript filepath to a JavaScript filepath in the same directory
    # Given the path /a/b/c.coffee it will return /a/b/c.js
    def convert_coffee_path_to_js(path)
      directory, basename = File.split(path)
      basename = File.basename(basename, '.coffee')
      "#{directory}/#{basename}.js"
    end



  end
end


