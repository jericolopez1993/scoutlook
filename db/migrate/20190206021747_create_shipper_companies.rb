class CreateShipperCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :shipper_companies do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :company_type
      t.string :phone_number
      t.string :website
      t.integer :shipper_id

      t.timestamps
    end
  end
end
