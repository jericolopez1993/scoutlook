class AddLastRemindToReminders < ActiveRecord::Migration[5.2]
  def up
    add_column :reminders, :last_reminded, :date
  end

  def down
    remove_column :reminders, :last_reminded
  end
end
