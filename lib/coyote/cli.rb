require 'coyote'
require 'optparse'

options = {}
OptionParser.new do |opts|
  Coyote::options.each do |name|
    opts.on("-#{name[0]}", "--#{name}", "#{name.capitalize}") { |o| options[name.to_sym] = o }
  end
end.parse!

if options[:version]
  puts "coyote #{Coyote::VERSION}"
  exit 0
end

input, output = ARGV[0].split(':', 2)

Coyote::run(input, output, options)