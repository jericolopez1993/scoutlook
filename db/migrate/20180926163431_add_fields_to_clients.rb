class AddFieldsToClients < ActiveRecord::Migration[5.2]
  def change
    add_column :clients, :volume_intra, :string
    add_column :clients, :volume_inter, :string
    add_column :clients, :volume_to_usa, :string
    add_column :clients, :volume_from_usa, :string
    add_column :clients, :notes, :text
    add_column :clients, :credit_status, :string
    add_column :clients, :credit_approval, :decimal
  end
end
