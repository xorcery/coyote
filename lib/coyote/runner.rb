# = root ../assets/javascripts
# = require vendor/jquery
# = require vendor/fancybox
# = require lib/keystone
# = require app/confio

module Coyote
  autoload :Asset, 'coyote/asset'

  class Runner
    attr_reader :assets

    def initialize(entry_point_path)
      @assets = {}
      entry_point = Asset.new(entry_point_path)
      @assets[entry_point.absolute_path] = entry_point
      add_dependencies_to_manifest(entry_point)
    end

    def add_dependencies_to_manifest(asset)
      asset.dependencies.each do |dependency|
        @assets[dependency.absolute_path] = @assets.delete(dependency.absolute_path)
        add_dependencies_to_manifest(dependency)
      end
    end
    
    def files
      @assets.collect { |path, asset| path }.reverse
    end
    

  end
end
