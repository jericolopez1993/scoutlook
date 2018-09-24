class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :client_id
      t.string :location_id
      t.string :name
      t.string :loc_type
      t.text :special_instructions
      t.string :address
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :phone

      t.timestamps
    end
  end
end
