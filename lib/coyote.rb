require 'coyote/bundle'
require 'coyote/fs_listener'

module Coyote

  def self.run(input_path, output_path, options = {})
    @@options = options
    bundle = Coyote::Bundle.new(input_path, output_path)
    build bundle
    watch bundle if @@options[:watch]
  end

  def self.build(bundle)
    bundle.compress! if @@options[:compress]
    bundle.log unless @@options[:quiet]
    bundle.save
  end

  def self.watch(bundle)
    listener = Coyote::FSListener.select_and_init

    listener.on_change do |changed_files|
      changed_files = bundle.files & changed_files

      unless changed_files.length <= 0
        puts "Detected change to #{changed_files}, recompiling...\n"
        bundle.update! changed_files
        build bundle
      end
    end

    listener.start
  end


end



