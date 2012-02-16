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
    end


    def files(absolute = false)
      @assets.collect do |path, asset|
        absolute ? asset.absolute_path : asset.relative_path
      end.reverse
    end


    def add(path)
      if File.directory? path
        add_directory path
      elsif File.exists? path
        add_asset path
      else
        notify "Could not find #{path}", :failure
      end
    end


    def update!(changed_files = [])
      @contents = ""

      unless changed_files.empty?
        changed_files.each do |path|
          @assets["#{Dir.pwd}/#{path}"].update!
        end
      end

      files(true).each { |path| @contents += "#{@assets[path].contents} \n\n" }
    end


    def compress!
      notify "#{Time.new.strftime("%I:%M:%S")}   Compressing bundle...", :warning
      compiler = ClosureCompiler.new.compile(@contents)
      if compiler.success?
        @contents = compiler.compiled_code
      elsif compiler.file_too_big?
        notify "Input code too big for API, creating uncompressed file\n", :failure
      elsif compiler.errors
        notify "Google closure API failed to compile, creating uncompressed file\n", :failure
        notify "Errors:", :failure
        notify "#{compiler.errors.to_s}", :failure
      end
    end

    def save
      output = File.open @output_path, 'w+'
      output.write @contents
      output.close
    end

    def manifest
      files.inject("") { |result, file| result + "\n + #{file}" }
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
