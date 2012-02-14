require 'benchmark'
require 'coyote/bundle'
require 'coyote/fs_listener'
require 'coyote/notifications'
include Coyote::Notifications


module Coyote
  
  VERSION = '1.0.1.beta'

  def self.run(input_path, output_path, options = {})
    @@input_path  = input_path
    @@output_path = output_path
    @@options     = options
    bundle = Coyote::Bundle.new(input_path, output_path)
    build bundle
    watch bundle if @@options[:watch]
  end


  def self.build(bundle)
    notify bundle.manifest unless @@options[:quiet]
    bundle.compress! if @@options[:compress]
    bundle.save
    notify "#{Time.new.strftime("%I:%M:%S")}   Saved bundle to #{@@output_path}   [#{bundle.files.length} files]", :success    
  end


  def self.watch(bundle)
    listener = Coyote::FSListener.select_and_init

    listener.on_change do |changed_files|
      changed_files = bundle.files & changed_files

      if changed_files.length > 0
        notify "#{Time.new.strftime("%I:%M:%S")}   Detected change, recompiling...", :warning
        bundle.update! changed_files
        build bundle
      end
    end

    notify "Watching for changes to your bundle. CTRL+C to stop."
    listener.start
  end

end



