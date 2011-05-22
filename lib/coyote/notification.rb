require 'appscript'

module Coyote
  class Notification
	  include Appscript
		
		attr_accessor :growl, :application, :icon, :default_notifications, :notifications 

		def initialize(message)
			@growl = app("GrowlHelperApp");

			if @growl.is_running?
				register
				notify message
			end
		end

		# register Coyote as an application with Growl
    def register
			@application = Coyote::APP_NAME
			@icon = "#{Coyote::CONFIG_PATH}/#{Coyote::CONFIG_ICON}"
	    @default_notifications = ["Coyote Success"]
	    @notifications = ["Coyote Success", "Coyote Failure"]
      @growl.register(:as_application => @application, :all_notifications => @notifications, :default_notifications => @default_notifications)
    end

		# trigger a growl notification
    def notify(message)
			options = { :title => @application,
									:description => message, 
									:application_name => @application, 
									:image_from_location => @icon, 
									:sticky => false, 
									:priority => 0, 
									:with_name => notifications.first }	
      @growl.notify options
    end		

	end
end