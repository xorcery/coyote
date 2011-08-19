module Coyote
  class Generator
		attr_accessor :files_found

		def initialize
			@files_found = []
		end

		def generate!
			if config_exists?
        Coyote::Notification.new "Coyote config already exists in this directory.\n", "failure"
			else
        discover_files
				copy_config
			end
		end

		def discover_files
			js_file_identifier = File.join("**","*#{Coyote::JAVASCRIPT_EXTENSION}")
      cs_file_identifier = File.join("**","*#{Coyote::COFFEESCRIPT_EXTENSION}")
			Dir.glob(js_file_identifier).each do |file|
				@files_found.push file
			end
			Dir.glob(cs_file_identifier).each do |file|
				@files_found.push file
			end
		end

		def config_exists?
			File.exists?(Coyote::CONFIG_FILENAME)
		end

		# copy sample coyote.yaml to directory
		def copy_config
      Coyote::Notification.new "\nGenerating Coyote\n"
      Coyote::Notification.new "#{@files_found.length} JavaScript files discovered\n"

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