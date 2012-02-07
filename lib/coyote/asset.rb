module Coyote
  class Asset

    attr_reader :relative_path, :absolute_path, :relative_directory, :absolute_directory

    def initialize(relative_path)
      @relative_path  = relative_path
      @absolute_path      = File.expand_path(@relative_path)
      @relative_directory = File.dirname(@relative_path)
      @absolute_directory = File.expand_path("#{Dir.pwd}/#{@relative_directory}")
      @contents           = File.exists?(@absolute_path) ? File.open(@absolute_path, 'r').read : ""
      find_and_add_required_assets_to_contents
    end

    def contents
      @contents
    end

    def contents=(string)
      @contents = string
    end

    def append(string)
      @contents += "\n\n" + string
    end
    
    def prepend(string)
      @contents = string + "\n\n" + @contents
    end
    
    def empty!
      @contents = ""
    end
    
    def empty?
      @contents.empty?
    end

    def save
      output = File.open @absolute_path, 'w+'
      output.write @contents
      output.close
    end

    def required_assets
      matches = @contents.scan(Regexp.new(/\/\/=\s*require\s*(.*)$/i))
      matches.collect do |match|
        self.class.new("#{@relative_directory}/#{match.last.strip}")
      end
    end
    
    def find_and_add_required_assets_to_contents
      required_assets.reverse.each do |asset|
        prepend asset.contents
      end
    end
  end
end