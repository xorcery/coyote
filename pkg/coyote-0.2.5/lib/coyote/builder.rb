module Coyote
  class Builder

		attr_accessor :config, :options, :input_files

		def initialize(options)
			@options = options
			@config = get_config_or_screw_off
			@input_files = []
		end
		

		def build
			output = Coyote::Output.new "#{@config['output']}"
			
			@config['input'].each do |key, value|
				add_input_files key
			end
									
			send_input_to_output output
			compress_and_save output
		end
		
		def add_input_files(input)
			if input.class == Array
				input.each do |input|
					@input_files.push input
				end
			elsif input.class == String 
				@input_files.push input
			end
		end


		def send_input_to_output(output)
			@input_files.each do |input|
				Dir.glob(input).each do |file|				
					output.append file
				end
			end			
		end
		
		
		def compress_and_save(output)
			if @options[:compress] || @config['compress']
				output.compress
			end

			output.save		
		end	


		def get_config_or_screw_off
			if File.exists?(Coyote::CONFIG_FILENAME)
				begin
					config = YAML.load(File.open(Coyote::CONFIG_FILENAME)) 
					if config.class == Hash && ! config.empty?					
				  	return config
					else
						print "Coyote configuration exists but has not been defined yet. Configure it in #{Coyote::CONFIG_FILENAME}\n".red
						exit(0)				
					end
				rescue ArgumentError => e
				  print "Could not parse YAML: #{e.message}\n".red
				  return false
				end
			else
				print "Could not find a Coyote configuration file in this directory. Use 'coyote generate' to create one.\n".red
				exit
			end
		end
		
		

  end
end