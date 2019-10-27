class CreateCarrierNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :carrier_notes do |t|
      t.integer :carrier_id
      t.integer :user_id
      t.text :notes

      t.timestamps
    end
  end
end
