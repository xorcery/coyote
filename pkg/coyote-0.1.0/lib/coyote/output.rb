module Coyote
  class Output
		
		attr_accessor :input, :output_file, :output_filename
		
		def initialize(output_filename) 
			@output_filename = output_filename
			@output_file = File.open(@output_filename, 'w+')
			@input = ""
			print "\n----- Creating #{@output_filename}\n".bold
		end

		# open file, add contents to output
		def append(filename)
			File.open(filename, 'r') do |file|
				@input += "/***** #{filename} *****/\n"
				@input += file.read
       	@input += "\n\n\n"
			end
			print "+ Added #{filename}\n"
		end

		# save output to file
		def save
			@output_file.write(@input)
			print "Saved to #{@output_filename} \n\n".green
		end
		
	end
end
			
		
