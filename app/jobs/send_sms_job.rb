class SendSmsJob < ApplicationJob
  queue_as :compose_sms

  def perform(numbers, message)
    numbers.split(',').map(&:to_s).each do |number|
      TwilioTextMessenger.new(message, number).text
    end
  end
end
