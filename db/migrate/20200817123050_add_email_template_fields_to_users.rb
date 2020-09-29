class AddEmailTemplateFieldsToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :position, :string
    add_column :users, :phone_number, :string
    add_column :users, :direct_number, :string
    add_column :users, :toll_free, :string
  end

  def down
    remove_column :users, :position
    remove_column :users, :phone_number
    remove_column :users, :direct_number
    remove_column :users, :toll_free
  end
end
