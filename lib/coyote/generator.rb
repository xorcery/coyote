module Coyote
  class Generator
		attr_accessor :files_found

		def initialize
			@files_found = []
		end

		def generate
			if config_exists?
        Coyote::Notification.new "This directory is already configured for Coyote.\n", "failure"
			else
        discover_files
				copy_config
			end
		end

		def discover_files
			js_files = File.join("**","*#{Coyote::JavaScript::EXTENSION}")
      cs_files = File.join("**","*#{Coyote::CoffeeScript::EXTENSION}")
			Dir.glob(js_files).each do |file|
				@files_found.push file
			end
			Dir.glob(cs_files).each do |file|
				@files_found.push file
			end
		end

		def config_exists?
			File.exists?(Coyote::CONFIG_FILENAME)
		end

		def copy_config
      Coyote::Notification.new "\nGenerating Coyote\n"
      Coyote::Notification.new "#{@files_found.length} files discovered\n"

			File.open("#{Coyote::CONFIG_PATH}/#{Coyote::CONFIG_FILENAME}") do |file|
				output_file = File.open(Coyote::CONFIG_FILENAME, 'w+')
				generated = file.read
				@files_found.each do |file|
				  generated += "  - #{file}\n"
				end
				output_file.write(generated)
			end

			Coyote::Notification.new "Coyote generated at #{Coyote::CONFIG_FILENAME}\n\n", "success"
		end
  end
end