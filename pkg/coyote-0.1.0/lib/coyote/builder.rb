require 'yaml'

module Coyote
  class Builder

		attr_accessor :input, :output

		def initialize
			@input = get_input_or_defaults
 			@output = Coyote::Output.new
			build
		end

		def build
			@input.each do |k,v|
				input_files = @input[k]['files']
				output_filename = @input[k]['output']

				input_files.each do |filename|
					puts filename
					@output.append(filename)
				end
				
				@output.save(output_filename)
			end
		end

		def get_input_or_defaults
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