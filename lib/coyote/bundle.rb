require 'coyote/asset'

module Coyote
  class Bundle
    attr_reader :assets

    def initialize
      empty!
    end

    def add(input)
      path = File.expand_path(input)
      asset = Coyote::Asset.new(path)
      
      @assets.delete(path)
      @assets[path] = asset
      
      asset.dependencies.each do |dependency_path|
        relative_directory = File.dirname asset.path.gsub("#{Dir.pwd}/", '')
        add File.join relative_directory, dependency_path
      end
    end


    def empty!
      @assets = {}
    end

    
    def files
      @assets.map { |path, asset| path }
    end


    def contents
      # TODO: use a proper enumerator
      @contents ||= files.map { |path| @assets[path].contents }.join
    end
    
    
    def update!(changed_files=[])
      reset!
      changed_files.each do |path|
        @assets[path].update!
      end
    end
    
    
    def reset!
      @contents = nil      
    end

  end
end
