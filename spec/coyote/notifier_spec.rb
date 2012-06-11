require 'coyote/notifier'

describe Coyote::Notifications do
  include Coyote::Notifications

  let(:message) { "Hello World" }

  context "#notify" do
    it "forwards notifications to Notifier" do
      Coyote::Notifier.should_receive(:notify).with(message, [])
      notify message
    end

    it "can timestamp the message" do
      Coyote::Notifier.should_receive(:timestamp)
      notify message, :timestamp
    end
    
    it "can color the message" do
      Coyote::Notifier.should_receive(:color).with(message, :green)
      notify message, :success
    end
  end 

end
