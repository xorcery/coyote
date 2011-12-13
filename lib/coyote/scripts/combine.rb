module Coyote
 	class Combine < Script


    def check_for_alternate_filetype(path)
      javascript = path
      coffeescript = convert_js_path_to_coffee(javascript)

      if File.file?(javascript)
        javascript
      elsif File.file?(coffeescript)
        coffeescript
      else
        nil
      end
    end


    def requires
      requires = []

      File.open(@filename).readlines.each do |line|
        @contents.gsub!(/#{line}/, '')

        if line.strip! != ''
          file = check_for_alternate_filetype(File.expand_path(line, @directory))
          if file
            requires << file
          end
        end
      end

      puts requires
      return requires
    end



  end
end
