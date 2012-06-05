module Coyote
  autoload :JavaScript,   'coyote/assets/javascript'
  autoload :CoffeeScript, 'coyote/assets/coffeescript'
  autoload :Less,         'coyote/assets/less'

  class Asset
    
    def self.choose(path)
      case File.extname(path)
      when /\.js/i      ; JavaScript.new(path)
      when /\.coffee/i  ; CoffeeScript.new(path)
      when /\.less/i    ; Less.new(path)
      else              ; self.new(path)
      end
    end
    
    
    attr_reader :path, :relative_path
    
    def initialize(path)
      @path = File.expand_path path
      @relative_path = @path.gsub("#{Dir.pwd}/", '')
    end

    def contents
      @contents ||= IO.read(@path)
    end

    def dependencies
      matches = contents.scan require_pattern
      matches.reverse.collect { |match| match.last.strip }
    end

    def update!
      @contents = nil
    end

    def require_pattern
      Regexp.new(/\/\/=\s*require\s*(.*)$/i)
    end

  end
end