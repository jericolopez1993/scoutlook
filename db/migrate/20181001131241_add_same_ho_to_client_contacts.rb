class AddSameHoToClientContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :client_contacts, :same_ho, :boolean, :default => false
  end
end
