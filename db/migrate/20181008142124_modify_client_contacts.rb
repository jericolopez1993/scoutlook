class ModifyClientContacts < ActiveRecord::Migration[5.2]
  def change
    rename_column :client_contacts, :name, :last_name
    add_column :client_contacts, :first_name, :string
  end
end
