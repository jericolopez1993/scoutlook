class AddCategoryToCarriers < ActiveRecord::Migration[5.2]
  def change
    add_column :carriers, :category, :string
  end
end
