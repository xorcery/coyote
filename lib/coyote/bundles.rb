require 'coyote/bundles/base'
require 'coyote/bundles/javascript'
require 'coyote/bundles/css'

module Coyote
  
  module Bundle
    def self.new(path)
      Coyote::Bundles.choose(path)
    end
  end
  
  module Bundles
    def self.choose(path)
      case File.extname(path)
      when /\.js/i      ; JavaScript.new(path)
      when /\.css/i     ; Css.new(path)
      else              ; Base.new(path)
      end
    end
  end
end