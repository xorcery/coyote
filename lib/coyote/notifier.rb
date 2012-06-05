require 'colored'

module Coyote
  class Notifier
    def self.notify(message, options)
      message = String(message)
      
      if options.include? :timestamp
        message = timestamp message
      end

      options.each do |option|
        if colors.has_key? option
          message = color(message, colors[option])
        end
      end

      puts message
    end

    def self.timestamp(message)
      "#{Time.new.strftime("%I:%M:%S")}      #{message}"
    end

    def self.color(message, color)
      message.send(color)
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


