class AddNotesAndTypeToReminder < ActiveRecord::Migration[5.2]
  def up
    add_column :reminders, :notes, :text
    add_column :reminders, :reminder_type, :string
  end

  def down
    remove_column :reminders, :notes
    remove_column :reminders, :reminder_type
  end
end
