module Coyote
  class Configuration

		attr_accessor :config, :options, :input_files

		def initialize(options)
			@options = options
			@config = get_config
			@input_files = []
		end

		def output_file
		  @config['output']
		end

		def should_compress?
		  @config['compress'] || options[:compress]
		end

		def hooks
      @config['hooks']
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
			return required
		end


		def get_config
			if File.exists?(Coyote::CONFIG_FILENAME)
				begin
					config = YAML.load(File.open(Coyote::CONFIG_FILENAME))
					if config.class == Hash && ! config.empty?
				  	return config
					else

            Coyote::Notification.new "Coyote configuration exists but has not been defined yet. Configure it in #{Coyote::CONFIG_FILENAME}\n", "failure"
						exit(0)
					end
				rescue ArgumentError => e
          Coyote::Notification.new "Could not parse YAML: #{e.message}\n", "failure"
				  exit
				end
			else
        Coyote::Notification.new "Could not find a Coyote configuration file in this directory. Use 'coyote new' to create one.\n", "failure"
				exit
			end
		end



  end
end