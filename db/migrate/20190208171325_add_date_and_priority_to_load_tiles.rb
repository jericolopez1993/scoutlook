class AddDateAndPriorityToLoadTiles < ActiveRecord::Migration[5.2]
  def up
    add_column :load_tiles, :load_date, :date
    add_column :load_tiles, :priority, :integer
  end

  def down
    remove_column :load_tiles, :load_date, :date
    remove_column :load_tiles, :priority, :integer
  end
end
