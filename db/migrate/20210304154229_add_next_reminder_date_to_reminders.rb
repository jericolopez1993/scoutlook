class AddNextReminderDateToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :next_reminder_date, :date
  end
end
