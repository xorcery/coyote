require 'colored'

module Coyote
  class Notifier
    def self.notify(message, options)
      message = format message
      if options.include? :timestamp
        message = timestamp message
      end

      options.each do |option|
        if colors.has_key? option
          message = message.send colors.fetch(option)
        end
      end

      puts message
    end

    def self.format(message)
      String(message) + "\n"
    end

    def self.timestamp(message)
      "#{Time.new.strftime("%I:%M:%S")}      #{message}"
    end

    def self.colors
      {:success => :green,
       :warning => :yellow,
       :failure => :red }
    end
  end

  module Notifications
    def notify(message, *args)
      Coyote::Notifier.notify(message, args)
    end
  end
end


