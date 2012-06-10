require 'coyote/assets'

module Coyote::Bundles
  class Base
    attr_reader :assets, :target
    
    def initialize(target)
      @target = target
      empty!
    end

    def add(input)
      path = File.expand_path(input)
      asset = Coyote::Asset.new(path)
    
      @assets.delete(path)
      @assets[path] = asset
    
      asset.dependencies.each do |dependency_path|
        relative_directory = File.dirname asset.relative_path
        add File.join relative_directory, dependency_path
      end
    end


    def empty!
      @assets = {}
    end

  
    def files
      @assets.keys
    end


    def contents
      # TODO: use a proper enumerator
      @contents ||= files.reverse.map { |path| @assets[path].contents }.join
    end
  
  
    def update!(changed_files=[])
      reset!
      changed_files.each do |path|
        @assets[path].update!
      end
    end
  
  
    def manifest
      files.reverse.map { |path| "+ #{path}" }.join("\n")
    end
  
  
    def reset!
      @contents = nil      
    end
    
    
    def save!
      File.open target, 'w+' do |file|
        file.write contents
      end      
    end
      
    

  end
end