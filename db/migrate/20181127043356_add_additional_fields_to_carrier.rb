class AddAdditionalFieldsToCarrier < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :complete_record, :boolean, :default => false
    add_column :carriers, :total_fleet_size, :string
    add_column :carriers, :website, :string
    add_column :carriers, :linkedin, :string
    remove_column :carriers, :sales_priority
    add_column :carriers, :sales_priority, :string
  end
end
