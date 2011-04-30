module Coyote
  class Builder

		attr_accessor :config

		def initialize(options)
			@config = get_config_or_defaults
			build
		end
		
		def build
			if config_defined?
				@config.each do |k,v|
					input_files = @config[k]['files']
					output_filename = @config[k]['output']
					output = Coyote::Output.new output_filename
			
					input_files.each do |filename|
						output.append(filename)
					end
				
					output.save
				end
			else
				print "Coyote configuration exists but has not been defined yet. Configure it in #{Coyote::CONFIG_FILENAME}\n".red
			end
		end


		def get_config_or_defaults
			if File.exists?(Coyote::CONFIG_FILENAME)
				parsed = begin
				  YAML.load(File.open(Coyote::CONFIG_FILENAME))
				rescue ArgumentError => e
				  print "Could not parse YAML: #{e.message}\n".red
				end
			else
				print "Could not find a Coyote configuration file in this directory.\n\n Use 'coyote generate' to create one.\n".red
			end
		end
		
		def config_defined?
			@config.class == Hash && ! @config.empty?
		end

  end
end