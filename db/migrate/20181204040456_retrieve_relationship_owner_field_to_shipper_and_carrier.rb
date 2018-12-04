class RetrieveRelationshipOwnerFieldToShipperAndCarrier < ActiveRecord::Migration[5.2]
  def change
    add_column :shippers, :relationship_owner, :integer
    add_column :carriers, :relationship_owner, :integer
  end
end
