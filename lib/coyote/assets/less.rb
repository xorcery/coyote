module Coyote::Assets
  class Less < Base

    def update!
      super
      compile!
    end

    def compile!
      @contents = `lessc #{@path}`
    end

  end    
end