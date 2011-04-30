require 'yaml'

module Coyote
  class Builder

		attr_accessor :input

		def initialize(options)
			@input = get_config_or_defaults
			build
		end
		
		def build
			@input.each do |k,v|
				input_files = @input[k]['files']
				output_filename = @input[k]['output']
				output = Coyote::Output.new output_filename

				input_files.each do |filename|
					output.append(filename)
				end
				
				output.save
			end
		end


		def get_config_or_defaults
			yaml_file = "coyote.yaml"

			if File.exists?(yaml_file)
				parsed = begin
				  YAML.load(File.open(yaml_file))
				rescue ArgumentError => e
				  puts "Could not parse YAML: #{e.message}"
				end
			else
				puts "Could not find Coyote configuration file"
			end
		end

  end
end