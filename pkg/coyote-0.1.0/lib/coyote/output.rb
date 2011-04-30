module Coyote
  class Output
		
		attr_accessor :input, :output_file, :output_filename
		
		def initialize(output_filename) 
			@output_filename = output_filename
			@output_file = File.open(@output_filename, 'w+')
			@input = ""
			puts "\n----- Creating #{@output_filename}"
		end

		# open file, add contents to output
		def append(filename)
			File.open(filename, 'r') do |file|
				@input += "/***** #{filename} *****/\n"
				@input += file.read
       	@input += "\n\n\n"
			end
			puts "+ Added #{filename}"
		end

		# save output to file
		def save
			@output_file.write(@input)
			puts "= Saved to #{@output_filename} \n\n"
		end

	end
end
			
		
