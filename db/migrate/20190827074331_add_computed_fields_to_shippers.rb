class AddComputedFieldsToShippers < ActiveRecord::Migration[5.2]
  def up
    add_column :shippers, :c_reminder_date, :date
    add_column :shippers, :c_reminder_id, :integer
    add_column :shippers, :c_reminder_notes, :text
    add_column :shippers, :c_reminder_interval, :string
    add_column :shippers, :c_reminder_type, :string
    add_column :shippers, :c_lane_destination, :string
    add_column :shippers, :c_lane_origin, :string
    add_column :shippers, :c_lane_id, :integer
    add_column :shippers, :c_auditable_last_activity_date, :datetime
  end

  def down
    remove_column :shippers, :c_reminder_date
    remove_column :shippers, :c_reminder_id
    remove_column :shippers, :c_reminder_notes
    remove_column :shippers, :c_reminder_interval
    remove_column :shippers, :c_reminder_type
    remove_column :shippers, :c_lane_destination
    remove_column :shippers, :c_lane_origin
    remove_column :shippers, :c_lane_id
    remove_column :shippers, :c_auditable_last_activity_date
  end
end
