class AddApprovedAndOtherFieldsToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :approved, :boolean, :default => false
    add_column :carriers, :mc_number, :string
    add_column :shippers, :approved, :boolean, :default => false
  end

  def down
    remove_column :carriers, :approved
    remove_column :carriers, :mc_number
    remove_column :shippers, :approved
  end
end
