class AddComputedDataShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :shippers, :c_activity_date_opened, :datetime
    add_column :shippers, :c_activity_campaign_name, :string
    add_column :shippers, :c_activity_activity_type, :string
    add_column :shippers, :c_activity_status, :boolean
  end

  def down
    remove_column :shippers, :c_activity_date_opened
    remove_column :shippers, :c_activity_campaign_name
    remove_column :shippers, :c_activity_activity_type
    remove_column :shippers, :c_activity_status
  end
end
