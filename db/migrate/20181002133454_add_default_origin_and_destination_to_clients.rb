class AddDefaultOriginAndDestinationToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :origin, :integer
    add_column :clients, :destination, :integer
    add_column :clients, :head_office, :integer
  end
end
