module Coyote
  class Generator
		
		attr_accessor :options
		
		@@config_path 		= File.expand_path(File.dirname(__FILE__) + "/../../config")
		@@config_filename = "coyote.yaml"
		@@copy_filename 	= "#{@@config_path}/#{@@config_filename}"		

		def initialize(options)
			@options = options
			generate
		end
		
		def generate
			if config_exists? && ! options[:force]
				puts "Coyote config already exists in this directory. Use --force to overwrite."				
			elsif config_exists? && options[:force] 
				copy_config
			elsif ! config_exists?
				copy_config
			end
		end

		# check to see if coyote.yaml already exists in directory
		def config_exists?
			File.exists?(@@config_filename)
		end
		
		# copy sample coyote.yaml to directory
		def copy_config
			File.open(@@copy_filename) do |file|
				output_file = File.open(@@config_filename, 'w+')
				output_file.write(file.read)
			end
		end			
  end
end