require 'coyote/dsl'


describe Coyote::DSL do

  it "calls the compiler" do
    input_file  = 'spec/assets/rake/input.coffee'
    output_file = 'spec/assets/rake/ouput.coffee'
    opts        = { :compress => true }

    Coyote.should_receive(:compile).with(input_file, output_file, opts)
    
    coyote do |config|
      config.input   = input_file
      config.output  = output_file
      config.options = opts
    end    
  end

end

