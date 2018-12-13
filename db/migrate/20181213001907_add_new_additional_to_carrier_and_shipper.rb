class AddNewAdditionalToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :load_last_month, :integer, :default => 0
    add_column :carriers, :load_last_6_month, :integer, :default => 0
    add_column :shippers, :load_last_month, :integer, :default => 0
    add_column :shippers, :load_last_6_month, :integer, :default => 0
  end

  def down
    remove_column :carriers, :load_last_month
    remove_column :carriers, :load_last_6_month
    remove_column :shippers, :load_last_month
    remove_column :shippers, :load_last_6_month
  end
end
