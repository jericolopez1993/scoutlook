class AddAcceptedToRates < ActiveRecord::Migration[5.2]
  def up
    add_column :rates, :accepted, :boolean, :default => false
  end

  def down
    remove_column :rates, :accepted
  end
end
