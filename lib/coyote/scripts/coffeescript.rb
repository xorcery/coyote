module Coyote
 	class CoffeeScript < Script

		def require_pattern
      Regexp.new(/#=\s*require\s(.*)$/i)
		end
		
		def contents=(string)
			@contents = string
		end

		def contents
			compile!
			@contents
		end

    def compile!
      @contents = `cat #{@filename} | coffee -sc`
    end

  end
end
