module Coyote
  class Generator
		
		attr_accessor :options
		
		def initialize(options)
			@options = options
		end
		
		def generate
			if config_exists? && ! options[:force]
				print "Coyote config already exists in this directory. Use --force to overwrite.\n".red				
			elsif (!config_exists?) || (config_exists? && options[:force])
				copy_config
			end			
		end

		# check to see if coyote.yaml already exists in directory
		def config_exists?
			File.exists?(Coyote::CONFIG_FILENAME)
		end
		
		# copy sample coyote.yaml to directory
		def copy_config
			print "\n----- Generating Coyote\n".bold
			File.open("#{Coyote::CONFIG_PATH}/#{Coyote::CONFIG_FILENAME}") do |file|
				output_file = File.open(Coyote::CONFIG_FILENAME, 'w+')
				output_file.write(file.read)
			end
			print "+ Coyote config generated at #{Coyote::CONFIG_FILENAME}\n"
			print "Coyote generated \n\n".green
		end
  end
end