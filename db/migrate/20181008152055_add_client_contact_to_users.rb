class AddClientContactToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :client_contact_id, :integer
  end
end
