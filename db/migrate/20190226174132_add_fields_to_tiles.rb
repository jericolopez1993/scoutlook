class AddFieldsToTiles < ActiveRecord::Migration[5.2]
  def up
    add_column :load_tiles, :salesperson_id, :integer
    add_column :load_tiles, :bill_rate, :integer
    add_column :load_tiles, :origin_city, :string
    add_column :load_tiles, :destination_city, :string
    add_column :load_tiles, :picks, :integer, :default => 1
    add_column :load_tiles, :drops, :integer, :default => 1
    add_column :load_tiles, :pu_time, :string
    add_column :load_tiles, :pu_general_time, :string
    add_column :load_tiles, :del_date, :date
    add_column :load_tiles, :del_time, :string
    add_column :load_tiles, :del_general_time, :string
    add_column :load_tiles, :teams, :boolean, :default => false
    add_column :load_tiles, :truck_tile_id, :integer

    add_column :truck_tiles, :dispatcher_id, :integer
    add_column :truck_tiles, :bill_rate, :integer
    add_column :truck_tiles, :pu_time, :integer
    add_column :truck_tiles, :pu_general_time, :string
    add_column :truck_tiles, :del_date, :date
    add_column :truck_tiles, :del_time, :integer
    add_column :truck_tiles, :del_general_time, :string
    add_column :truck_tiles, :teams, :boolean, :default => false
  end

  def down
    remove_column :load_tiles, :salesperson_id
    remove_column :load_tiles, :bill_rate
    remove_column :load_tiles, :origin_city
    remove_column :load_tiles, :destination_city
    remove_column :load_tiles, :picks
    remove_column :load_tiles, :drops
    remove_column :load_tiles, :pu_time
    remove_column :load_tiles, :del_date
    remove_column :load_tiles, :del_time
    remove_column :load_tiles, :teams
    remove_column :load_tiles, :truck_tile_id

    remove_column :truck_tiles, :dispatcher_id
    remove_column :truck_tiles, :bill_rate
    remove_column :truck_tiles, :pu_time
    remove_column :truck_tiles, :del_date
    remove_column :truck_tiles, :del_time
    remove_column :truck_tiles, :teams
  end
end
