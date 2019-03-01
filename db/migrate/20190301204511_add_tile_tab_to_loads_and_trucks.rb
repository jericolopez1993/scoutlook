class AddTileTabToLoadsAndTrucks < ActiveRecord::Migration[5.2]
  def up
    add_column :load_tiles, :tile_tab_id, :integer
    add_column :truck_tiles, :tile_tab_id, :integer
  end

  def down
    remove_column :load_tiles, :tile_tab_id
    remove_column :truck_tiles, :tile_tab_id
  end
end
