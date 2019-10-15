class RenameColumnsToDfLoads < ActiveRecord::Migration[5.2]
  def change
    rename_column :df_loads, "Load_Num", :load_num
    rename_column :df_loads, "Ship_Date", :ship_date
    rename_column :df_loads, "Customer", :customer
    rename_column :df_loads, "Origin", :origin
    rename_column :df_loads, "OS", :os
    rename_column :df_loads, "Destination", :destination
    rename_column :df_loads, "DS", :ds
    rename_column :df_loads, "MC_Num", :mc_num
    rename_column :df_loads, "Carrier", :carrier
    rename_column :df_loads, "Curr", :curr
    rename_column :df_loads, "TTT", :ttt
    rename_column :df_loads, "Billing", :billing
    rename_column :df_loads, "GM", :gm
    rename_column :df_loads, "GMPER", :gmper
    rename_column :df_loads, "Cust_Sys", :cust_sys
    rename_column :df_loads, "Carr_Sys", :carr_sys
    rename_column :df_loads, "Gross_Margin", :gross_margin
    rename_column :df_loads, "Exchange_Rate", :exchange_rate
    rename_column :df_loads, "Sales", :sales
    rename_column :df_loads, "Dispatch", :dispatch
    rename_column :df_loads, "Truck", :truck

  end
end
