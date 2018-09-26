class CreateActivityOutcomes < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_outcomes do |t|
      t.string :outcome
      t.string :reason
      t.text :notes

      t.timestamps
    end
  end
end
