require 'coyote/assets/base'
require 'coyote/assets/javascript'
require 'coyote/assets/coffeescript'
require 'coyote/assets/less'

module Coyote
  
  module Asset
    def self.new(path)
      Coyote::Assets.choose(path)
    end
  end
  
  module Assets
    def self.choose(path)
      case File.extname(path)
      when /\.js/i      ; JavaScript.new(path)
      when /\.coffee/i  ; CoffeeScript.new(path)
      when /\.less/i    ; Less.new(path)
      else              ; Base.new(path)
      end
    end
  end
end