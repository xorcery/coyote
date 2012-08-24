module Coyote::Bundles
  class CSS < Base
    filetypes :css, :less

    def compress!
      notify "Compressing bundle...", :warning, :timestamp
      tmp = "#{@target}.#{Time.now.to_i}.less"
      File.open(tmp, 'w+') { |f| f.write contents }
      self.contents = `lessc #{tmp} --yui-compress`
      File.delete tmp
    end

    def contents
      @contents ||= @assets[files.first].compile!.contents
    end

  end
end

