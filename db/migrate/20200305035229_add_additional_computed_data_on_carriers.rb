class AddAdditionalComputedDataOnCarriers < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :c_activity_date_opened, :datetime
    add_column :carriers, :c_activity_campaign_name, :string
    add_column :carriers, :c_activity_activity_type, :string
    add_column :carriers, :c_activity_status, :boolean
    add_column :carriers, :c_carr_new_loads_lw, :integer
    add_column :carriers, :c_carr_new_loads_2w, :integer
    add_column :carriers, :c_carr_new_loads_3w, :integer
    add_column :carriers, :c_carr_new_loads_4w, :integer
  end

  def down
    remove_column :carriers, :c_activity_date_opened
    remove_column :carriers, :c_activity_campaign_name
    remove_column :carriers, :c_activity_activity_type
    remove_column :carriers, :c_activity_status
    remove_column :carriers, :c_carr_new_loads_lw
    remove_column :carriers, :c_carr_new_loads_2w
    remove_column :carriers, :c_carr_new_loads_3w
    remove_column :carriers, :c_carr_new_loads_4w
  end
end
