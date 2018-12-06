class AddAlternativeDecisionMakerToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def change
    add_column :carrier_contacts, :adm, :boolean, :default => false
    add_column :shipper_contacts, :adm, :boolean, :default => false
  end
end
