class ModifyClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :client_id
    add_column :clients, :client_contact_id, :integer
  end
end
