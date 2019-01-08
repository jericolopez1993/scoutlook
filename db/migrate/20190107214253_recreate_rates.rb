class RecreateRates < ActiveRecord::Migration[5.2]
  def up
    create_table :rates do |t|
      t.string :rate_type
      t.integer :parent_id
      t.string :rate_level
      t.string :effective_to
      t.string :effective_from
      t.string :freight_desc
      t.string :freight_classification
      t.string :transit_time
      t.string :minimum_density
      t.integer :activity_id
      t.string :origin_city, default: ""
      t.string :origin_state, default: ""
      t.string :origin_country, default: ""
      t.string :destination_city, default: ""
      t.string :destination_state, default: ""
      t.string :destination_country, default: ""
      t.integer :user_id
      t.string :miles
      t.integer :picks
      t.integer :drops
      t.boolean :team
      t.string :commodities
      t.decimal :bid
      t.decimal :ask
      t.decimal :cost
      t.string :money_currency
      t.text :notes
      t.string :mc_number

      t.timestamps
    end
      drop_table :carrier_rates
      drop_table :shipper_rates
  end

  def down
    drop_table :rates
  end
end
