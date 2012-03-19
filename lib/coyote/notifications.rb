require 'term/ansicolor'
include Term::ANSIColor

module Coyote
  module Notifications

    def self.notify(msg, type = "message")
      notify msg, type
    end

    def notify(msg, type = :message)
      msg = "#{msg}\n"
      case type
      when :success           ; print msg.green
      when :warning           ; print msg.yellow
      when :failure           ; print msg.red
      else                    ; print msg.white
      end
    end

  end
end
