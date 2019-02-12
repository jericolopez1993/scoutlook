class AddEligibleForTexting < ActiveRecord::Migration[5.2]
  def change
    add_column :carrier_contacts, :primary_eligible_texting, :boolean, :default => false
    add_column :carrier_contacts, :secondary_eligible_texting, :boolean, :default => false
    add_column :shipper_contacts, :primary_eligible_texting, :boolean, :default => false
    add_column :shipper_contacts, :secondary_eligible_texting, :boolean, :default => false
  end
end
