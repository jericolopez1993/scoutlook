class AddSheetNameToPlanningSheets < ActiveRecord::Migration[5.2]
  def change
    add_column :planning_sheets, :sheet_name, :string
    add_column :planning_sheets, :active, :boolean, :default => true
  end
end
