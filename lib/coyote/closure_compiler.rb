require 'net/http'
require 'rexml/document'

module Coyote
  class ClosureCompiler

    def initialize
      @request = Net::HTTP::Post.new('/compile', 'Content-type' => 'application/x-www-form-urlencoded')
    end

    def compile(content)
      @content = content
      params = {
        'compilation_level' => 'ADVANCED_OPTIMIZATIONS',
        'output_format' => 'xml',
        'output_info' => 'compiled_code',
        'js_code' => @content
      }

      @request.set_form_data(params)
      begin
        res = Net::HTTP.new('closure-compiler.appspot.com', 80).start {|http| http.request(@request) }
        case res
        when Net::HTTPSuccess
          @doc = REXML::Document.new(res.body)
        end
      rescue REXML::ParseException => msg
        print "Failed: #{msg}\n".red
      rescue
        #these should be caught by external checking
      end

      self
    end

    def success?
      @doc && @doc.root && @doc.root.elements['serverErrors'].nil?
    end

    def errors
      unless @doc
        nil
      else
        @doc.root.elements["serverErrors"]
      end
    end

    def compiled_code
      @doc.root.elements['compiledCode'].text
    end

    def file_too_big?
      @doc && @doc.root && @doc.root.elements["serverErrors/error[@code='8']"] != nil
    end
  end
end
