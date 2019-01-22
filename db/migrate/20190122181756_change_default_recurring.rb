class ChangeDefaultRecurring < ActiveRecord::Migration[5.2]
  def up
    change_column :reminders, :recurring, :boolean, :default => false
  end
end
