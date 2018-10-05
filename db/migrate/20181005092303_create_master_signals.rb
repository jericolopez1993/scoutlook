class CreateMasterSignals < ActiveRecord::Migration[5.2]
  def change
    create_table :master_signals do |t|
      t.string :signal_type
      t.date :signal_date
      t.integer :client_id
      t.integer :client_contact_id
      t.integer :rate_id
      t.string :origin_city
      t.string :origin_state
      t.string :origin_country
      t.string :destination_city
      t.string :destination_state
      t.string :destination_country
      t.date :start_date
      t.date :end_date
      t.string :duration
      t.integer :volume
      t.string :uom
      t.string :per
      t.string :capacity_type
      t.string :max_origin
      t.string :max_destination
      t.string :desired_rate
      t.text :notes
      t.boolean :same_origin
      t.boolean :same_origin_hoc
      t.boolean :same_destination
      t.boolean :same_destination_hoc

      t.timestamps
    end
  end
end
