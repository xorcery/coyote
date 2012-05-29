require 'optparse'

options = {}
OptionParser.new do |opts|
  ['compress', 'watch', 'quiet', 'version'].each do |name|
    opts.on("-#{name[0]}", "--#{name}", "#{name.capitalize}") { |o| options[name.to_sym] = o }
  end
end.parse!

if options[:version]
  puts "coyote #{Coyote::VERSION}"
  exit 0
end

input, output = ARGV.fetch(0, "").split(':', 2)

Coyote.compile(input, output, options)