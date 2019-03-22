class SendSmsJob < ApplicationJob
  queue_as :compose_sms

  def perform(numbers, message)
    numbers.split(',').map(&:to_s).each do |number|
      num = E164.normalize(number)
      TwilioTextMessenger.new(message, num).text
    end
  end
end
