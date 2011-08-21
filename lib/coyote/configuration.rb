module Coyote
  class Configuration

		attr_accessor :options, :output
		attr_reader :inputs

		def initialize(options = {})
			@options = options
		  @inputs = []
      @output = Coyote::Defaults::OUTPUT
		end


		def should_compress?
      @options['compress'] || false
		end


    def inputs=(inputs)
      inputs.each { |input| add_input input }
    end


		def add_input(input)
			if input.class == Array
				input.each do |input|
					find_and_add_files input
				end
			elsif input.class == String and @output != input
				find_and_add_files input
			end
		end


		def load_from_yaml!(yaml_file = Coyote::CONFIG_FILENAME)
			if File.exists?(yaml_file)
				begin
					config = YAML.load(File.open(yaml_file))
					if config.class == Hash && ! config.empty?
            self.inputs = config['input']
            @output = config['output']
            if config['options'] && config['options'].class == Hash
              @options = config['options'].merge(@options)
            end
					else
            Coyote::Notification.new "Coyote configuration exists but has not been defined yet. Configure it in #{yaml_file}\n", "failure"
						exit(0)
					end
				rescue ArgumentError => e
          Coyote::Notification.new "Could not parse YAML: #{e.message}\n", "failure"
				  exit
				end
			else
        Coyote::Notification.new "Could not find a Coyote configuration file #{yaml_file}. Use 'coyote new' to create one.\n", "failure"
				exit
			end
		end



		private

		def find_and_add_files(input)
			Dir.glob(input).each do |file|
				required = find_requires file
				required.each do |requirement|
					find_and_add_files "**/#{requirement}.js"
				end
				if ! @inputs.include? file
					@inputs.push file
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

  end
end