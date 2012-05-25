require 'coyote/asset'

module Coyote
  class Bundle
    attr_reader :assets

    def initialize
      empty!
    end

    def add input
      path = File.expand_path(input)
      asset = Coyote::Asset.new(path)
      @assets[path] = asset
      
      asset.dependencies.each do |dependency_path|
        relative_directory = File.dirname asset.path.gsub("#{Dir.pwd}/", '')
        add File.join relative_directory, dependency_path
      end
    end

    def empty!
      @assets = {}
    end

    def contents
      @assets.map { |p,a| a.contents }.reduce(&:+)
    end

  end
end
