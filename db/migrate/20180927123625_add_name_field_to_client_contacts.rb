class AddNameFieldToClientContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :client_contacts, :name, :string
  end
end
