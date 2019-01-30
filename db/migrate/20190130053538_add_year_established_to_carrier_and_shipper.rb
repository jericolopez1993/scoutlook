class AddYearEstablishedToCarrierAndShipper < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :years_established, :integer
    add_column :shippers, :years_established, :integer
  end

  def down
    remove_column :carriers, :years_established
    remove_column :shippers, :years_established
  end
end
