class ModifyClients < ActiveRecord::Migration[5.2]
  def change
    remove_column :clients, :client_id
  end
end
