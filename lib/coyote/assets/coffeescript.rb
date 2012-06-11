module Coyote::Assets
  class CoffeeScript < Base
    require_pattern Regexp.new(/#=\s*require\s(.*)$/i)

    def update!
      super
      compile!
    end
    
    def compile!
      @contents = `cat #{@path} | coffee -sc`
      self
    end
    
  end    
end