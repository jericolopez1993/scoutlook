class ReminderBroadcastJob < ApplicationJob
  queue_as :default

  def perform(reminder)
    ActionCable.server.broadcast "reminder_channel:#{reminder.user_id}", data: reminder.to_json
  end
end
