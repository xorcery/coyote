require 'coyote/compiler'

describe Coyote::Compiler do
  
  let(:source_file)   { "spec/assets/compiler/javascript/script3.js" }
  let(:required_file) { "spec/assets/compiler/javascript/script4.js" }
  let(:output_path)   { "spec/assets/compiler/javascript/output.js"  }

  before :each do
    File.delete output_path if File.exist? output_path
    @compiler = Coyote::Compiler.new(source_file)
  end

  context ".new" do
    it "creates a bundle from an input file" do
      # TODO: this is a shitty test
      @compiler.bundle.should_not be_nil
    end
  end
  
  context "#save" do
    it "saves the bundle contents to disk" do
      @compiler.save(output_path)
      IO.read(output_path).should == IO.read(source_file) + IO.read(required_file)
    end
  end
end