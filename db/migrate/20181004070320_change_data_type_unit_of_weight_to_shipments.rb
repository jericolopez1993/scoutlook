class ChangeDataTypeUnitOfWeightToShipments < ActiveRecord::Migration[5.2]
  def change
    remove_column :shipments, :unit_of_weight
    add_column :shipments, :unit_of_weight, :string
  end
end
