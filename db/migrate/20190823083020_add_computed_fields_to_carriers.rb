class AddComputedFieldsToCarriers < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :c_reminder_date, :date
    add_column :carriers, :c_reminder_id, :integer
    add_column :carriers, :c_reminder_notes, :text
    add_column :carriers, :c_reminder_interval, :string
    add_column :carriers, :c_reminder_type, :string
    add_column :carriers, :c_lane_destination, :string
    add_column :carriers, :c_lane_origin, :string
    add_column :carriers, :c_lane_id, :integer
    add_column :carriers, :c_mc_latest_date_tier, :string
    add_column :carriers, :c_mc_latest_date_last_month, :integer
    add_column :carriers, :c_mc_latest_date_last_6_months, :integer
    add_column :carriers, :c_mc_latest_date_load_days, :integer
    add_column :carriers, :c_auditable_last_activity_date, :datetime
  end

  def down
    remove_column :carriers, :c_reminder_date
    remove_column :carriers, :c_reminder_id
    remove_column :carriers, :c_reminder_notes
    remove_column :carriers, :c_reminder_interval
    remove_column :carriers, :c_reminder_type
    remove_column :carriers, :c_lane_destination
    remove_column :carriers, :c_lane_origin
    remove_column :carriers, :c_lane_id
    remove_column :carriers, :c_mc_latest_date_tier
    remove_column :carriers, :c_mc_latest_date_last_month
    remove_column :carriers, :c_mc_latest_date_last_6_months
    remove_column :carriers, :c_mc_latest_date_load_days
    remove_column :carriers, :c_auditable_last_activity_date
  end
end
