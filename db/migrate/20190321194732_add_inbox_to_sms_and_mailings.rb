class AddInboxToSmsAndMailings < ActiveRecord::Migration[5.2]
  def up
    add_column :mailings, :inbox, :boolean, :default => false
    add_column :messages, :inbox, :boolean, :default => false
  end

  def down
    remove_column :mailings, :inbox
    remove_column :messages, :inbox
  end
end
