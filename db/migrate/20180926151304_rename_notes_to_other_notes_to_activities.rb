class RenameNotesToOtherNotesToActivities < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :activities, :notes, :other_notes
  end

  def self.down
    rename_column :activities, :other_notes, :notes
  end
end
