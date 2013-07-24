module Coyote::Assets
  class Less < Base
    require_pattern Regexp.new(/@import\s*['|"](.*)['|"]\s*;$/i)


    def find_dependencies
      super
      @dependencies.map! do |file|
        path = File.expand_path(File.join(File.dirname(@relative_path), file))
        if File.exists? path
          file
        elsif File.exists?(path + ".less")
          file + ".less"
        else
          nil
        end
      end.compact!
    end


    def compile!
      Bundler.with_clean_env do
        @contents = `lessc #{@path}`
      end
      self
    end

  end    
end
