class AddStatusAndDateSentInMailings < ActiveRecord::Migration[5.2]
  def up
    add_column :mailings, :status, :string
    add_column :mailings, :date_sent, :datetime

  end

  def down
    remove_column :mailings, :status
    remove_column :mailings, :date_sent
  end
end
