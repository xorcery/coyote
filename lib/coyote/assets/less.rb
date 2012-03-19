module Coyote
  class Less < Asset
    def update!
      super
      compile!
    end

    protected
    
    # Defines the regex pattern for scanning the contents of the
    # file to look for require directives
    def require_pattern
      Regexp.new(/\/\/=\s*require\s(.*)$/i)  # '//= require a/b/c.less' => 'a/b/c.less'
    end

    private

    def compile!
      @contents = `lessc #{@absolute_path}`
    end
  end
end
