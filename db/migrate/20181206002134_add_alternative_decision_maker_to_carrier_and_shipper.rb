class AddAlternativeDecisionMakerToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carrier_contacts, :adm, :boolean, :default => false
    add_column :shipper_contacts, :adm, :boolean, :default => false
  end

  def down
    remove_column :carrier_contacts, :adm
    remove_column :shipper_contacts, :adm
  end
end
