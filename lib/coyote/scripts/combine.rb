module Coyote

  # This class adds support for .combine files, following the style
  # of SassAndCoffee for .NET (https://github.com/xpaulbettsx/SassAndCoffee)

 	class Combine < Script

    # .combine files serve primarily as a manifest listing files to pull in and combine
    # In turn, each line of a .combine file is a require directive, so what we do here
    # to detemine requires is read in each line of the file, do a bit of cleanup,
    # and return an array of full filepaths of the required files
    def requires
      requires = []

      File.open(@filename).readlines.each do |line|
        # Because the directives in the .combine file are not comments,
        # we have to strip out the directives from the file's contents
        @contents.gsub!(/#{line}/, '')

        # Clean up whitespace on the directive, and make sure it's not a blank line
        if line.strip! != ''

          # The .NET .combine engine automatically detects .js files as their .coffee counterparts
          # so we need to replicate that functionality and also look for .coffee files with the same filename
          file = check_for_alternate_filetype(File.expand_path(line, @directory))
          if file
            requires << file
          end
        end
      end

      return requires
    end


    # This method with look for an alternate filetype for a given filepath
    # If it is given a path of /a/b/c.js it will look for /a/b/c.coffee
    # and return whichever filetype it finds first
    # It looks for JavaScript first and then CoffeeScript, returning nil if it doesn't find anything
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

  end
end
