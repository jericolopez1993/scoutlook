class ReminderChannel < ApplicationCable::Channel
  def subscribed
    stream_from "reminder_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
