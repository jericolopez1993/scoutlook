class CreateLoadTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :load_tiles do |t|
      t.string :name
      t.string :status
      t.string :origin
      t.string :destination
      t.text :details
      t.integer :carrier_id
      t.integer :shipper_id

      t.timestamps
    end
  end
end
