class AddDateStampToActivities < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_activities, :date_stamp, :date
    add_column :shipper_activities, :date_stamp, :date
  end
  def down
    remove_column :carrier_activities, :date_stamp
    remove_column :shipper_activities, :date_stamp
  end
end
