require 'benchmark'
require 'fileutils'
require 'coyote/bundle'
require 'coyote/fs_listener'
require 'coyote/notifications'
include Coyote::Notifications

module Coyote
  
  VERSION = '1.0.3'
  
  def self.run(input_path, output_path, options = {})
    @@input_path  = input_path
    @@output_path = output_path
    @@options     = options
    @@bundle      = Coyote::Bundle.new(input_path, output_path)
    build { |bundle| bundle.update! }
    watch if @@options[:watch]
  end


  def self.options
    ['compress', 'watch', 'quiet', 'version']
  end


  def self.build(&block)
    time = Benchmark.realtime do
      yield @@bundle unless block.nil?
      notify @@bundle.manifest unless @@options[:quiet]
      @@bundle.compress! if @@options[:compress]
      @@bundle.save
    end

    notify "#{Time.new.strftime("%I:%M:%S")}   Saved bundle to #{@@output_path}   [#{@@bundle.files.length} files in #{(time).round(5)}s]", :success    
  end


  def self.watch
    listener = Coyote::FSListener.select_and_init

    listener.on_change do |changed_files|
      changed_files = @@bundle.files & changed_files

      if changed_files.length > 0
        notify "#{Time.new.strftime("%I:%M:%S")}   Detected change, recompiling...", :warning
        build { |bundle| bundle.update! changed_files }
      end
    end

    notify "#{Time.new.strftime("%I:%M:%S")}   Watching for changes to your bundle. CTRL+C to stop."
    listener.start
  end
end