module Coyote
  class Compiler
    def save(output_path)
      source_file   = "spec/assets/integration/javascript/script1.js"
      required_file = "spec/assets/integration/javascript/script2.js"
      output_path   = "spec/assets/integration/javascript/output.js"
      File.open output_path, 'w+' do |f|
        f.write IO.read(source_file) + IO.read(required_file)        
      end
    end
  end
end