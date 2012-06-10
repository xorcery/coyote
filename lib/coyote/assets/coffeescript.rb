module Coyote::Assets
  class CoffeeScript < Base

    def update!
      super
      compile!
    end

    def compile!
      @contents = `cat #{@path} | coffee -sc`
    end
        
    def require_pattern
      Regexp.new(/#=\s*require\s(.*)$/i)
    end

  end    
end