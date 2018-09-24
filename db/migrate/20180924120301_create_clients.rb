class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.string :client_type
      t.integer :relationship_owner
      t.string :company_name
      t.string :client_id
      t.string :parent_id
      t.integer :sales_priority
      t.string :address
      t.string :city
      t.string :state
      t.string :postal
      t.string :country
      t.string :phone
      t.decimal :annual_revenue
      t.string :industry
      t.string :primary_industry
      t.string :hazardous
      t.string :food_grade
      t.decimal :freight_revenue

      t.timestamps
    end
  end
end
