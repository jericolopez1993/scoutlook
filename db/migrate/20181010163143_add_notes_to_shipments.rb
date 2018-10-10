class AddNotesToShipments < ActiveRecord::Migration[5.2]
  def change
    add_column :shipments, :notes, :text
  end
end
