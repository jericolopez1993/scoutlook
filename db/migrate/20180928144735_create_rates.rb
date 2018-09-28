class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.integer :client_id
      t.string :rate_type
      t.integer :parent_id
      t.string :rate_level
      t.integer :rep_id
      t.string :effective_to
      t.string :effective_from
      t.string :origin_city
      t.string :origin_state
      t.string :origin_country
      t.string :destination_city
      t.string :destination_state
      t.string :destination_country
      t.string :freight_desc
      t.string :freight_classification
      t.string :transit_time
      t.string :minimum_density

      t.timestamps
    end
  end
end
