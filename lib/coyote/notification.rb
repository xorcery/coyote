module Coyote
  class Notification

		attr_accessor :growl, :application, :icon, :default_notifications, :notifications, :type, :message

		def initialize(message, type = "message")
      @message = message
      @type = type

			console_notify

			if Config::CONFIG['target_os'] =~ /darwin/i
				require 'appscript'
				@growl = Appscript.app("GrowlHelperApp");

				if @growl.is_running?
					growl_register
					growl_notify
				end
			end
		end


    def console_notify
    	case @type
    	when "success"
        print @message.green
    	when "warning"
        print @message.yellow
      when "failure"
        print @message.red
    	else
        print @message.white
    	end
    end


		# trigger a growl notification
		def growl_notify
			options = { :title => @application,
									:description => @message.gsub(/[\n]+/, ""),
									:application_name => @application,
									:image_from_location => @icon,
									:sticky => false,
									:priority => 0,
									:with_name => notifications.first }
      @growl.notify options			
		end	


		# register Coyote as an application with Growl
    def growl_register
			@application = Coyote::APP_NAME
			@icon = "#{Coyote::CONFIG_PATH}/#{Coyote::CONFIG_ICON}"
	    @default_notifications = ["Coyote Success"]
	    @notifications = ["Coyote Success", "Coyote Failure"]
      @growl.register(:as_application => @application, :all_notifications => @notifications, :default_notifications => @default_notifications)
    end


	end
end