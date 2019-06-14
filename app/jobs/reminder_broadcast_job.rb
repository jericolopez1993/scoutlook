class ReminderBroadcastJob < ApplicationJob
  queue_as :default

  def perform(reminder)
     ActionCable.server.broadcast 'reminder_channel', data: Reminder.find(reminder.id).to_json
   end
end
