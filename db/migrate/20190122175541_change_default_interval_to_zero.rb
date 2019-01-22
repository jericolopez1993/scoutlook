class ChangeDefaultIntervalToZero < ActiveRecord::Migration[5.2]
  def up
    change_column :reminders, :reminder_interval, :integer, :default => 0
  end
end
