class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.integer :carrier_id
      t.integer :shipper_id
      t.integer :activity_id
      t.integer :user_id
      t.date :reminder_date
      t.integer :reminder_interval
      t.boolean :recurring

      t.timestamps
    end
  end
end
