require 'coyote/assets'
require 'coyote/compressors'

module Coyote::Bundles
  class Base

    class << self
      def filetypes(*args)
        @filetypes ||= args.map { |arg| arg.to_s.gsub('.','') } || []
      end

      def compressor(klass = nil)
        @compressor ||= klass || :Dummy
      end        
    end
    
    filetypes :js, :coffee, :css, :less
    compressor :Dummy

    attr_reader :assets, :target, :compressor
    
    def initialize(target)
      @target = target
      @compressor = Coyote::Compressors.new(self.class.compressor)
      empty!
    end

    def add(input)
      path = File.expand_path(input)
      asset = Coyote::Asset.new(path)
    
      unless self.class.filetypes.include? File.extname(path).gsub('.','')
        return false 
      end
    
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
    

    def compress!
      @contents = @compressor.compress(contents)
    end
      
    

  end
end