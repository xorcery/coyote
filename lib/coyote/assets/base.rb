module Coyote::Assets
  class Base

    class << self
      def require_pattern(pattern = nil)
        @require_pattern ||= pattern || Regexp.new(/\/\/=\s*require\s*(.*)$/i)
      end
    end
    
        
    require_pattern Regexp.new(/\/\/=\s*require\s*(.*)$/i)
    
    attr_accessor :contents
    attr_reader :path, :relative_path, :contents, :dependencies

    def initialize(path)
      @path = File.expand_path path
      @relative_path = @path.gsub("#{Dir.pwd}/", '')
      update!
    end

    def find_dependencies
      matches = self.contents.scan self.class.require_pattern
      @dependencies = matches.reverse.map { |match| match.last.strip }
    end

    def update!
      self.contents = IO.read(@path)
      find_dependencies
    end

  end
end