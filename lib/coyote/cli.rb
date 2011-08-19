module Coyote
	def self.generate
    Coyote::Generator.new.generate!
	end

	def self.build(options)
		puts options
	end

	def self.watch(options)
		puts options
	end

	def self.usage
	  file = File.open("#{Coyote::CONFIG_PATH}/#{Coyote::USAGE_FILENAME}", 'r')
		puts file.read
		file.close
	end
end