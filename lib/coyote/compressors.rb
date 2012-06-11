require 'coyote/compressors/dummy'
require 'coyote/compressors/javascript'
require 'coyote/compressors/css'

module Coyote
  module Compressors
    def self.new(compressor)
      const_get(compressor.to_s).new
    end
  end
end