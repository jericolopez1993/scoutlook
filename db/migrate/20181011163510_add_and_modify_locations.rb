class AddAndModifyLocations < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :address, :string
    add_column :locations, :state, :string
    add_column :locations, :postal, :string
    add_column :locations, :country, :string
    rename_column :locations, :name, :city
  end
end
