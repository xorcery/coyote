module Coyote
  class Configuration

		attr_accessor :options, :output, :source
		attr_reader :inputs

		def initialize(options = {})
			@options = options
		  @inputs = {}
      @output = Coyote::Defaults::OUTPUT
		end


		def should_compress?
      @options['compress'] || false
		end


    def inputs=(inputs)
      add_input inputs
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
            @source = yaml_file
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

		def find_and_add_files(path)
			Dir.glob(path).each do |file|
				# Grab the absolute path of the file 
				# so we can ensure we don't have duplicate inputs
				filename = File.absolute_path(file)

				script = Coyote::Script.new(filename)
				
				script.requires.each { |path| find_and_add_files(path) }
				
				if @inputs[filename].nil?
					@inputs[filename] = script 
				end
			end
		end




  end
end