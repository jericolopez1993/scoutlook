class ChangeDateFormatInRemindersDate < ActiveRecord::Migration[5.2]
  def up
    change_column :reminders, :reminder_date, :datetime
  end

  def down
    change_column :reminders, :reminder_date, :date
  end
end
