class AddCarrierManagementFieldsToCarrier < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :interview, :boolean, default: false
    add_column :carriers, :wolfbyte, :boolean, default: false

  end

  def down
    remove_column :carriers, :interview
    remove_column :carriers, :wolfbyte
  end
end
