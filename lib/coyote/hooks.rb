module Coyote
  class Hooks

    def initialize(hooks)
      @hooks = hooks || {}
    end

    def invoke(segment)
      if @hooks[segment] and ! @hooks[segment].strip.empty?
        command = @hooks[segment]
        Coyote::Notification.new "\nInvoking hook '#{segment}' - '#{command}' \n"
        output = `#{command}`
        Coyote::Notification.new "#{output}\n" if output != ""
      end
    end

  end
end
