module Coyote

  # This class adds support for .combine files, following the style
  # of SassAndCoffee for .NET (https://github.com/xpaulbettsx/SassAndCoffee)

 	class Combine < Asset

    # .combine files serve primarily as a manifest listing files to pull in and combine
    # In turn, each line of a .combine file is a require directive, so what we do here
    # to detemine requires is read in each line of the file as a require
    def find_dependencies
      @dependencies = []

      File.open(@absolute_path).readlines.each do |line|
        # Because the directives in the .combine file are not comments,
        # we have to strip out the directives from the file's contents
        @contents.gsub!(/#{line}/, '')

        # Clean up whitespace on the directive, and make sure it's not a blank line
        next if line.strip! == ''

        path = "#{@relative_directory}/#{line}"

        # The .NET .combine engine automatically detects .js files as their .coffee counterparts
        # so we need to replicate that functionality and also look for .coffee files with the same filename

        # First check if the JavaScript version exists
        # Otherwise look for a CoffeeScript version
        javascript_path = path
        coffeescript_path = path.gsub(/.js$/i,'.coffee')

        if File.exists? javascript_path
          @dependencies << javascript_path
        elsif File.exists? coffeescript_path
          @dependencies << coffeescript_path
        end
      end
      
      @dependencies.reverse!
    end
    
  end
end
