module Coyote::Bundles
  class CSS < Base
    filetypes :css, :less

    def compress!
      notify "Compressing bundle...", :warning, :timestamp
      tmp = "#{@target}.#{Time.now.to_i}.less"
      File.open(tmp, 'w+') { |f| f.write contents }
      Bundler.with_clean_env do
        self.contents = `lessc #{tmp} -x`
      end
      File.delete tmp
    end

    def contents
      @contents ||= @assets[files.first].compile!.contents
    end

  end
end

