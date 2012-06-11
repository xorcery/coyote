require 'coyote/closure_compiler'

module Coyote::Bundles
  class JavaScript < Base
    filetypes :js, :coffee

    def compress!
      notify "Compressing bundle...", :warning, :timestamp
      compiler = Coyote::ClosureCompiler.new.compile(self.contents)
      if compiler.success?
        self.contents = compiler.compiled_code
      elsif compiler.file_too_big?
        notify "Input code too big for API, creating uncompressed file\n", :failure
      elsif compiler.errors
        notify "Google closure API failed to compile, creating uncompressed file\n", :failure
        notify "Errors:", :failure
        notify "#{compiler.errors.to_s}", :failure
      end      
    end
  end    
end