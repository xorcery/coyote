module Coyote
  class Asset

    attr_reader :relative_path, :absolute_path, :relative_directory, :absolute_directory

    def initialize(relative_path)
      @relative_path      = relative_path
      @absolute_path      = File.expand_path(@relative_path)
      @relative_directory = File.dirname(@relative_path)
      @absolute_directory = File.expand_path("#{Dir.pwd}/#{@relative_directory}")
      @contents           = File.exists?(@absolute_path) ? File.open(@absolute_path, 'r').read : ""
    end

    def dependencies
      matches = @contents.scan(Regexp.new(/\/\/=\s*require\s*(.*)$/i))
      matches.collect do |match|
        self.class.new("#{@relative_directory}/#{match.last.strip}")
      end
    end

  end
end
