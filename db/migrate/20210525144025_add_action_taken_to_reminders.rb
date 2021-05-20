class AddActionTakenToReminders < ActiveRecord::Migration[5.2]
  def change
    add_column :reminders, :action_taken, :integer, :default => 0
  end
end