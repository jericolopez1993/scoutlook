class AddLoadNumbersToActivities < ActiveRecord::Migration[5.2]
  def up
    add_column :activities, :load_numbers, :integer
  end

  def down
    remove_column :activities, :load_numbers
  end
end
 
