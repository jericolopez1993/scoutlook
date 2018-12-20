class AddLastLoadDateToCarrier < ActiveRecord::Migration[5.2]
  def up
    add_column :carriers, :last_load_date, :date
  end
  def down
    remove_column :carriers, :last_load_date
  end
end
