class AddLinkedinToClientContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :client_contacts, :linkedin_link, :string
  end
end
