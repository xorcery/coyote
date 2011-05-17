module Coyote
  class ConfigReader

		attr_accessor :config, :options, :input_files

		def initialize(options)
			@options = options
			@config = get_config_or_screw_off
			@input_files = []
		end
		
		def output_file
		  return @config['output']
		end
		
		def should_compress?
		  return @config['compress'] || options[:compress]
		end

		def find_input_files
		  @input_files = []
			@config['input'].each { |input| add_input input }
		end


		def add_input(input)
			if input.class == Array
				input.each do |input|
					find_and_add_files input
				end
			elsif input.class == String and @config['output'] != input
				find_and_add_files input
			end
		end

		
		def find_and_add_files(input)
			Dir.glob(input).each do |file|
				required = find_requires file
				required.each do |requirement|
					find_and_add_files "**/#{requirement}.js"
				end
				if ! @input_files.include? file
					@input_files.push file
				end
			end
		end


		def find_requires(input_file)
			required = []
			File.open(input_file) do |file|
				file = file.read
				pattern = Regexp.new(/(\/\/.*)(require )(.*)$/x)
				matches = file.scan(pattern)
				matches.each do |match|
					required.push match.last.strip.to_s.gsub(/\.js/, '').gsub(/(\"|\')/, '')
				end
			end
			#puts required
			return required
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