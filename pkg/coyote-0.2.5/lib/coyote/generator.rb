module Coyote
  class Generator
		
		attr_accessor :options, :files_found
		
		def initialize(options)
			@options = options
			@files_found = []
		end
		
		def generate
			discover_files
			if config_exists? && ! options[:force]
				print "Coyote config already exists in this directory. Use --force to overwrite.\n".red				
			elsif (!config_exists?) || (config_exists? && options[:force])
				copy_config
			end
		end
		
		def discover_files
			js_files = File.join("**","*.js")
			Dir.glob(js_files).each do |file|				
				@files_found.push file
			end		
		end

		# check to see if coyote.yaml already exists in directory
		def config_exists?
			File.exists?(Coyote::CONFIG_FILENAME)
		end
		
		# copy sample coyote.yaml to directory
		def copy_config
			print "\n----- Generating Coyote\n".bold
			print "#{@files_found.length} JavaScript files discovered\n"
			File.open("#{Coyote::CONFIG_PATH}/#{Coyote::CONFIG_FILENAME}") do |file|
				output_file = File.open(Coyote::CONFIG_FILENAME, 'w+')
				generated = file.read
				@files_found.each do |file|
				  generated += "  - #{file} \n"
				end
				output_file.write(generated)
			end
			print "Coyote generated at #{Coyote::CONFIG_FILENAME}\n\n".green
		end
  end
end