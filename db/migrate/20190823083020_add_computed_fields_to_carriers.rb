class AddComputedFieldsToCarriers < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :c_reminder_date, :date
    add_column :carriers, :c_reminder_id, :integer
    add_column :carriers, :c_reminder_notes, :text
    add_column :carriers, :c_reminder_interval, :string
    add_column :carriers, :c_reminder_type, :string
    add_column :carriers, :c_lane_destination, :string
    add_column :carriers, :c_lane_origin, :string
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
    remove_column :carriers, :c_mc_latest_date_tier
    remove_column :carriers, :c_mc_latest_date_last_month
    remove_column :carriers, :c_mc_latest_date_last_6_months
    remove_column :carriers, :c_mc_latest_date_load_days
    remove_column :carriers, :c_auditable_last_activity_date
  end
end

#
# SELECT created_at FROM audits WHERE ((auditable_type = 'Carrier' AND auditable_id IN (carriers.id)) OR (auditable_type = 'CarrierCompany' AND auditable_id IN (SELECT carrier_companies.id FROM carrier_companies WHERE carrier_companies.carrier_id = carriers.id)) OR (auditable_type = 'CarrierContact' AND auditable_id IN (SELECT carrier_contacts.id FROM carrier_contacts WHERE carrier_contacts.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLane' AND auditable_id IN (SELECT carrier_lanes.id FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLocation' AND auditable_id IN (SELECT carrier_locations.id FROM carrier_locations WHERE carrier_locations.carrier_id = carriers.id)) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT activities.id FROM activities WHERE activities.carrier_id = carriers.id)) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT rates.id FROM rates WHERE rates.carrier_id = carriers.id)) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT reminders.id FROM reminders WHERE reminders.carrier_id = carriers.id))) ORDER BY created_at DESC LIMIT 1) AS last_activity_date
