module Coyote::Bundles
  class CSS < Base
    filetypes :css, :less
    compressor :CSS
  end
end