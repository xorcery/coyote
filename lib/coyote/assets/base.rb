module Coyote::Assets
  class Base
    attr_reader :path, :relative_path, :contents

    def initialize(path)
      @path = File.expand_path path
      @relative_path = @path.gsub("#{Dir.pwd}/", '')
      update!
    end

    def dependencies
      matches = contents.scan require_pattern
      matches.reverse.collect { |match| match.last.strip }
    end

    def update!
      @contents = IO.read(@path)
    end

    def require_pattern
      Regexp.new(/\/\/=\s*require\s*(.*)$/i)
    end

  end
end