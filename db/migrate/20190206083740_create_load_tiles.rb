class CreateLoadTiles < ActiveRecord::Migration[5.2]
  def change
    create_table :load_tiles do |t|
      t.string :name
      t.string :status
      t.integer :load_list_id
      t.string :origin
      t.string :destination
      t.text :details

      t.timestamps
    end
  end
end
