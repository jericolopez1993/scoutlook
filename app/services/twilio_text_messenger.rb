class TwilioTextMessenger
  attr_reader :message, :phone_number

  def initialize(message, phone_number)
    @message = message
    @phone_number = phone_number
  end

  def text
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.secrets.twilio_phone_number,
      to: phone_number,
      body: message
    })
  end
end
