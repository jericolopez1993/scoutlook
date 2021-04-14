class CreatePlanningSheets < ActiveRecord::Migration[5.2]
  def change
    create_table :planning_sheets do |t|
      t.string :sheet_url
      t.integer :created_by

      t.timestamps
    end
  end
end
