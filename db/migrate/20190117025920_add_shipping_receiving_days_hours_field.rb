class AddShippingReceivingDaysHoursField < ActiveRecord::Migration[5.2]
  def change
    add_column :shipper_locations, :receiving_day, :string
    add_column :shipper_locations, :receiving_hour, :integer
    add_column :shipper_locations, :shipping_day, :string
    add_column :shipper_locations, :shipping_hour, :integer
  end
end
