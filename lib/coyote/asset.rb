module Coyote
  autoload :JavaScript,   'coyote/assets/javascript'
  autoload :CoffeeScript, 'coyote/assets/coffeescript'

  class Asset

    attr_reader :relative_path, :absolute_path, :relative_directory, :absolute_directory
    attr_accessor :contents

    # Determine the type of file based on the file extension
    # and return an instance of the proper asset class
    def self.select_and_init(path)
      case File.extname(path)
      when /\.js/i      ; JavaScript.new(path)
      when /\.coffee/i  ; CoffeeScript.new(path)
      else              ; self.new(path)
      end
    end


    def initialize(relative_path)
      @relative_path      = relative_path
      @absolute_path      = File.expand_path(@relative_path)
      @relative_directory = File.dirname(@relative_path)
      @absolute_directory = File.expand_path("#{Dir.pwd}/#{@relative_directory}")
      @contents           = File.exists?(@absolute_path) ? File.open(@absolute_path, 'r').read : ""
    end

    def dependencies
      matches = @contents.scan(Regexp.new(/\/\/=\s*require\s*(.*)$/i))
      matches.reverse.collect { |match| "#{@relative_directory}/#{match.last.strip}" }
    end

  end
end
