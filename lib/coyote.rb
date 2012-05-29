require 'coyote/version'
require 'coyote/compiler'
require 'coyote/notifier'
include Coyote::Notifications

module Coyote
  
  def self.compile(input, output, options={})
    Compiler.new(input, output, options).compile!
  end

end