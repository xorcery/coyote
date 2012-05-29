require 'coyote'


# silence CLI output for tests
module Coyote
  class Notifier
    def self.notify(*args)
      self 
    end
  end
end