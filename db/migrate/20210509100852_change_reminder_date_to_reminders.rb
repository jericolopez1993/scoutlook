class ChangeReminderDateToReminders < ActiveRecord::Migration[5.2]
  def up
   change_column :reminders, :reminder_date, :datetime
   change_column :carriers, :c_reminder_date, :datetime
   change_column :shippers, :c_reminder_date, :datetime
 end

 def down
   change_column :reminders, :reminder_date, :date
   change_column :carriers, :c_reminder_date, :date
   change_column :shippers, :c_reminder_date, :date
 end
end
