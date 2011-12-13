module Coyote
 	class CoffeeScript < Script

    # Defines the regex pattern for scanning the contents of the
    # file to look for require directives
    def require_pattern
      Regexp.new(/#=\s*require\s(.*)$/i)  # '#= require a/b/c.coffee' => 'a/b/c.coffee'
    end


    # We're defining setters and getters here
    # for the contents of the script file
    # because we need to compile the CoffeeScript to JavaScript
    # on the way out
    def contents=(string)
      @contents = string
    end

    def contents
      compile!
      @contents
    end


    # Run the contents of the script through the CoffeeScript compile
    # Changes the content of the script in-place
    def compile!
      @contents = `cat #{@filename} | coffee -sc`
    end

  end
end
