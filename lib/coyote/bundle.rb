require 'coyote/closure_compiler'

module Coyote
  autoload :Asset, 'coyote/asset'

  class Bundle

    attr_reader :contents

    def initialize(entry_point, output_path)
      @output_path = output_path
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


    def compress!
      puts "Compiling bundle...\n"
      compiler = ClosureCompiler.new.compile(@contents)
      if compiler.success?
        @contents = compiler.compiled_code
      elsif compiler.file_too_big?
        puts "Input code too big for API, creating uncompiled file\n"
      elsif compiler.errors
        puts "Google closure API failed to compile, creating uncompiled file\n"
        puts "Errors: \n"
        puts "#{compiler.errors.to_s}\n\n"
      end
    end


    def save
      output = File.open @output_path, 'w+'
      output.write @contents
      output.close      
      puts "Saved #{@output_path}"
    end

    def log
      # TODO: add verbose logging feature
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
