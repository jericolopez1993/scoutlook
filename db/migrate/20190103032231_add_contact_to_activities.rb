class AddContactToActivities < ActiveRecord::Migration[5.2]
  def change
    add_reference :shipper_activities, :shipper_contact, index: true
    add_reference :carrier_activities, :carrier_contact, index: true
  end
end
