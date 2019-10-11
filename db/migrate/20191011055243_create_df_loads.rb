class CreateDfLoads < ActiveRecord::Migration[5.2]
  def change
    create_table :df_loads do |t|
      t.text "Load_Num"
      t.datetime "Ship_Date"
      t.text "Customer"
      t.text "Origin"
      t.text "OS"
      t.text "Destination"
      t.text "DS"
      t.text "MC_Num"
      t.text "Carrier"
      t.text "Curr"
      t.bigint "TTT"
      t.bigint "Billing"
      t.bigint "GM"
      t.text "GMPER"
      t.bigint "Cust_Sys"
      t.bigint "Carr_Sys"
      t.bigint "Gross_Margin"
      t.float "Exchange_Rate"
      t.text "Sales"
      t.text "Dispatch"
      t.text "Truck"
      t.timestamps
    end
  end
end
