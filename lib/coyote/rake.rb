require 'coyote/dsl'

def coyote(*args, &block)
  runner = Coyote::DSL.new(&block)

  args ||= []

  args.insert 0, :build
  Rake::Task.define_task(*args) do
    runner.options[:watch] = false
    runner.run
  end

  args[0] = :watch
  Rake::Task.define_task(*args) do
    runner.options[:watch] = true
    runner.run
  end

  args[0] = :compress
  Rake::Task.define_task(*args) do
    runner.options[:compress] = true
    runner.options[:watch] = false
    runner.run
  end

end
