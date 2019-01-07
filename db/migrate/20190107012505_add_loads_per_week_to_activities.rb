class AddLoadsPerWeekToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :carrier_activities, :loads_per_week, :string
    add_column :shipper_activities, :loads_per_week, :string
  end
end
