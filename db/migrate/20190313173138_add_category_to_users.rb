class AddCategoryToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :carrier_categories, :string
    add_column :users, :shipper_categories, :string
  end
  
  def down
    remove_column :users, :carrier_categories
    remove_column :users, :shipper_categories
  end
end
