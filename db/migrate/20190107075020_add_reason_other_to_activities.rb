class AddReasonOtherToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :carrier_activity_outcomes, :reason_other, :string
    add_column :shipper_activity_outcomes, :reason_other, :string
  end
end
