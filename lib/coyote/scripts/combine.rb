module Coyote
 	class Combine < Script

    def requires
      File.open(@filename).readlines.collect do |line|
				@contents.gsub!(/#{line}/, '')
				line.strip
      end
    end

	end
end
