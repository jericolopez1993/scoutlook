class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :type
      t.string :engagement_type
      t.integer :client_id
      t.integer :rep_id
      t.string :annual_value
      t.boolean :status
      t.timestamp :date_opened
      t.timestamp :date_closed
      t.text :notes
      t.integer :outcome_id

      t.timestamps
    end
  end
end
