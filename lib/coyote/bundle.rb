# = root ../assets/javascripts
# = require vendor/jquery
# = require vendor/fancybox
# = require lib/keystone
# = require app/confio

module Coyote
  autoload :Asset, 'coyote/asset'

  class Bundle

    attr_reader :contents

    def initialize(entry_point)
      @assets = {}
      @contents = ""
      add entry_point
      update!
    end


    def files
      @assets.collect { |path, asset| path }.reverse
    end


    def add(path)
      if File.directory? path
        add_directory path
      elsif File.exists? path
        add_asset path
      else
        puts "Could not find #{path}"
      end      
    end


    def update!
      @contents = "" 
      files.each { |path| @contents += "#{@assets[path].contents} \n\n" }
    end    


    private

    def add_asset(path)
      asset = Asset.select_and_init(path)

      unless @assets[asset.absolute_path].nil?
        @assets.delete(asset.absolute_path)
      end

      @assets[asset.absolute_path] = asset
      add_dependencies(asset)
    end


    def add_directory(dir_path)
      Dir.foreach(dir_path) do |path| 
        next if path == '.' or path == '..'
        add "#{dir_path}/#{path}"
      end
    end


    def add_dependencies(asset)
      asset.dependencies.each { |path| add path }
    end

  end
end
