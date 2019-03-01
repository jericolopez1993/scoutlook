class CreateTileTabs < ActiveRecord::Migration[5.2]
  def change
    create_table :tile_tabs do |t|
      t.string :name
      t.text :notes
      t.integer :created_by

      t.timestamps
    end
  end
end
