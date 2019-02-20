class CreateTruckTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :truck_tiles do |t|
      t.string :name
      t.string :status
      t.string :origin
      t.string :destination
      t.text :details
      t.integer :carrier_id
      t.integer :shipper_id
      t.date :load_date
      t.integer :priority

      t.timestamps
    end
  end
end
