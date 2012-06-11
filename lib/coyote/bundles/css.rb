module Coyote::Bundles
  class CSS < Base
    filetypes :css, :less

    def compress!
      tmp = "#{@target}.#{Time.now.to_i}.less"
      File.open(tmp, 'w+') { |f| f.write contents }
      self.contents = `lessc #{tmp} -x`
      File.delete tmp
    end
  end
end

