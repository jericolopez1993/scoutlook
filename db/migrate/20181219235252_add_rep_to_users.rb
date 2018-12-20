class AddRepToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :ro, :boolean, :default => false
    add_column :users, :cs, :boolean, :default => false
    add_column :carrier_activities, :user_id, :integer
    add_column :carrier_rates, :user_id, :integer
    add_column :shipper_activities, :user_id, :integer
    add_column :shipper_rates, :user_id, :integer
    remove_column :carrier_activities, :rep_id
    remove_column :carrier_rates, :rep_id
    remove_column :shipper_activities, :rep_id
    remove_column :shipper_rates, :rep_id
  end

  def down
    remove_column :users, :ro
    remove_column :users, :cs
    remove_column :carrier_activities, :user_id
    remove_column :carrier_rates, :user_id
    remove_column :shipper_activities, :user_id
    remove_column :shipper_rates, :user_id
    add_column :carrier_activities, :rep_id, :integer
    add_column :carrier_rates, :rep_id, :integer
    add_column :shipper_activities, :rep_id, :integer
    add_column :shipper_rates, :rep_id, :integer
  end
end
