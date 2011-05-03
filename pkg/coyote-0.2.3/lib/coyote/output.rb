module Coyote
  class Output

		attr_accessor :input, :input_files, :output_file, :output_filename

		def initialize(output_filename)
			@output_filename = output_filename
			@output_file = File.open(@output_filename, 'w+')
			@input_files = []
			@input = ""
			print "\n----- Creating #{@output_filename}\n".bold
		end

		# open file, add contents to output
		def append(filename)
		  if File.exists?(filename) 
			  @input_files.push(filename)
			  File.open(filename, 'r') do |file|
			  	@input += "/***** #{filename} *****/\n"
			  	@input += file.read
         	@input += "\n\n\n"
			  end
			  print "+ Added #{filename}\n"
			else
			  print "! Error adding #{filename}\n"
			end
		end

		# save output to file
		def save
			add_file_comments
			@output_file.write(@input)
			print "Saved to #{@output_filename} \n\n".green
			@output_file.close
		end

		def add_file_comments
			file_comments = "// Compressed using Coyote\n\n// Files included:\n"
			@input_files.each do |file|
				file_comments += "// #{file}\n"
			end
			file_comments += "\n\n\n"
			@input = file_comments + @input
		end

		# compress output
		def compress
			print "Compiling #{@output_filename}...\n"
			@input = Closure::Compiler.new.compile(@input)
		end
	end
end


