class AddPreviousMcAndBlackListedToCarriers < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :previous_mc_number, :string
    add_column :carriers, :blacklisted, :boolean, :default => false
  end

  def down
    remove_column :carriers, :previous_mc_number
    remove_column :carriers, :blacklisted
  end
end
