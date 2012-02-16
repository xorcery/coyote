require 'coyote'

def coyote(task_name, *args, &block)

  args ||= []

  args.insert 0, task_name
  
  # Create an anonymous class with input, output and options accessors
  config = Struct.new(:input, :output, :options).new

  # Start off with options as an empty hash
  config.options = {}

  # Give them the config struct to configure in the block
  yield config
    
  # Make sure we've got an input
  if config.input.empty?
    notify "Coyote: Input filepath must be defined", :failure
    exit 0
  end

  # Make sure we've got an output  
  if config.output.empty?
    notify "Coyote: Output filepath must be defined", :failure
    exit 0
  end

  # If they call the task 'watch', then let's set the watch option for them
  if task_name == :watch
    config.options[:watch] = true
  end
  
  # Pass the runner along to Rake as a proc
  body = proc { 
    Coyote::run(config.input, config.output, config.options) 
  }
  
  Rake::Task.define_task(*args, &body)
end
