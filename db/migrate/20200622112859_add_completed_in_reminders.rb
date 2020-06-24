class AddCompletedInReminders < ActiveRecord::Migration[5.2]
  def up
    add_column :reminders, :completed, :boolean, :default => false
    add_column :carriers, :c_reminder_completed, :boolean, :default => false
    add_column :shippers, :c_reminder_completed, :boolean, :default => false
  end

  def down
    remove_column :reminders, :completed
    remove_column :carriers, :c_reminder_completed
    remove_column :shippers, :c_reminder_completed
  end
end
