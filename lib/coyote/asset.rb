module Coyote
  class Asset
    
    attr_reader :path
    
    def initialize(path)
      @path = path
    end

    def contents
      @contents ||= IO.read(@path)
    end

    def dependencies
      matches = contents.scan require_pattern
      matches.reverse.collect { |match| match.last.strip }
    end

    def require_pattern
      Regexp.new(/\/\/=\s*require\s*(.*)$/i)
    end

  end
end