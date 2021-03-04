class CreateGlobalSummaries < ActiveRecord::Migration[5.2]
  def change
    create_table :global_summaries do |t|
      t.integer :reminder_total
      t.string :reminder_ids
      t.integer :log_total
      t.string :log_ids
      t.integer :last_updated_by

      t.timestamps
    end
  end
end
