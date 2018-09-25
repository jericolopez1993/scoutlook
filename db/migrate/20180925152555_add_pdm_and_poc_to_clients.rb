class AddPdmAndPocToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :pdm_id, :integer
    add_column :clients, :poc_id, :integer
    remove_column :clients, :client_contact_id
  end
end
