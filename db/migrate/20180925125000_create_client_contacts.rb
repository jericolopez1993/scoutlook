class CreateClientContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :client_contacts do |t|
      t.string :title
      t.string :email
      t.string :work_phone
      t.string :home_phone
      t.string :address
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.integer :client_id

      t.timestamps
    end
  end
end
