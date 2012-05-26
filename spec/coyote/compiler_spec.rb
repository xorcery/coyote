require 'coyote/compiler'

describe Coyote::Compiler do
  
  let(:input_file)   { "spec/assets/compiler/javascript/script3.js" }
  let(:required_file) { "spec/assets/compiler/javascript/script4.js" }
  let(:output_file)   { "spec/assets/compiler/javascript/output.js"  }

  before :each do
    File.delete output_file if File.exist? output_file
  end

  context ".new" do
    it "creates a bundle from an input file" do
      compiler = Coyote::Compiler.new(input_file, output_file)
      # TODO: this is a shitty test
      compiler.bundle.should_not be_nil
    end
  end

  describe "options" do
    context "watch" do
      it "calls #watch when the :watch option is passed" do
        options = {:watch => true}
        compiler = Coyote::Compiler.new(input_file, output_file, options)        
        compiler.should_receive :watch
        compiler.compile!
      end
    end
  end

  
  context "#compile!" do
    it "compiles and saves the bundle" do
      compiler = Coyote::Compiler.new(input_file, output_file)
      compiler.should_receive :save!
      compiler.compile!
    end
    
    it "calls #watch if the :watch option is set to true" do
      options = {:watch => true}
      compiler = Coyote::Compiler.new(input_file, output_file, options)        
      compiler.should_receive :watch
      compiler.compile!
    end
    
    it "doesn't call #watch if the :watch option is falsy" do
      possible_options = [{:watch => false}, {:watch => nil}, {}, nil]
      possible_options.each do |options|
        compiler = Coyote::Compiler.new(input_file, output_file, options)        
        compiler.should_not_receive :watch
        compiler.compile!
      end
    end
  end

  
  context "#save!" do
    it "saves the bundle contents to disk" do
      Coyote::Compiler.new(input_file, output_file).compile!
      IO.read(output_file).should == IO.read(input_file) + IO.read(required_file)
    end
  end
  

  
  

  
end