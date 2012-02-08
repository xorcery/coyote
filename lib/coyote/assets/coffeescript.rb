module Coyote
 	class CoffeeScript < Asset


    def update!
      super
      compile!
    end


    protected

    # Defines the regex pattern for scanning the contents of the
    # file to look for require directives
    def require_pattern
      Regexp.new(/#=\s*require\s(.*)$/i)  # '#= require a/b/c.coffee' => 'a/b/c.coffee'
    end


    private

    def compile!
      @contents = `cat #{@absolute_path} | coffee -sc`
    end



  end
end
