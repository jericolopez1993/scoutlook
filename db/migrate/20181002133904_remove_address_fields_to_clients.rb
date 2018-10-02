class RemoveAddressFieldsToClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :address
    remove_column :clients, :city
    remove_column :clients, :state
    remove_column :clients, :postal
    remove_column :clients, :country
  end
end
