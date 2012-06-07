require 'coyote'

# A compiler is a thing that can create and save bundles
# A bundle is a thing that hold a bunch of assets
# An asset is a representation of a file on disk


describe 'integrated Coyote compiler' do
  context "javascript" do
    it "combines multiple files" do
      source_file   = "spec/assets/integration/javascript/script1.js"
      required_file = "spec/assets/integration/javascript/script2.js"
      output_path   = "spec/assets/integration/javascript/output.js"
      File.delete output_path if File.exist? output_path
      Coyote.compile(source_file, output_path)
      IO.read(output_path).should == IO.read(required_file) + IO.read(source_file)
    end
  end
end


