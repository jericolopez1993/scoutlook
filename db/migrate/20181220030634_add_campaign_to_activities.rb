class AddCampaignToActivities < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_activities, :campaign_name, :string, :default => ""
    add_column :shipper_activities, :campaign_name, :string, :default => ""
  end

  def down
    remove_column :carrier_activities, :campaign_name
    remove_column :shipper_activities, :campaign_name
  end
end
