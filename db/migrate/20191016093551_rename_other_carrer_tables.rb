class RenameOtherCarrerTables < ActiveRecord::Migration[5.2]
  def change
    #CarrNew
    rename_column :carr_new, "Carrier_Name", :carrier_name
    rename_column :carr_new, "Contact", :contact
    rename_column :carr_new, "Load_Last_Month", :load_last_month
    rename_column :carr_new, "First_Load_Date", :first_load_date
    rename_column :carr_new, "Last_Load_Date", :last_load_date
    rename_column :carr_new, "Gross_Margin_%", :gross_margin
    rename_column :carr_new, "Last_OS", :last_os
    rename_column :carr_new, "Last_DS", :last_ds
    rename_column :carr_new, "Loads_LW", :loads_lw
    rename_column :carr_new, "Loads_2W", :loads_2w
    rename_column :carr_new, "Loads_3W", :loads_3w
    rename_column :carr_new, "Loads_4W", :loads_4w
    rename_column :carr_new, "Phone#1", :phone1
    rename_column :carr_new, "Phone#2", :phone2
    rename_column :carr_new, "Prime Status", :prime_status
    rename_column :carr_new, "MC#", :mc_number
    rename_column :carr_new, "Owner", :owner
    #CarrProm
    rename_column :carr_prom, "Carrier_Name", :carrier_name
    rename_column :carr_prom, "Current_Tier", :current_tier
    rename_column :carr_prom, "Previous_Tier", :previous_tier
    rename_column :carr_prom, "Highest_Tier", :highest_tier
    rename_column :carr_prom, "Highest_Tier_Date", :highest_tier_date
    rename_column :carr_prom, "Gross_Margin_%", :gross_margin
    rename_column :carr_prom, "Load_Last_Week", :load_last_week
    rename_column :carr_prom, "Load_Last_Month", :load_last_month
    rename_column :carr_prom, "Load_Last_3_Months", :load_last_3_months
    rename_column :carr_prom, "Load_Last_6_Months", :load_last_6_months
    rename_column :carr_prom, "Highest_Tier_Reached", :highest_tier_reached
    rename_column :carr_prom, "Phone#1", :phone1
    rename_column :carr_prom, "Phone#2", :phone2
    rename_column :carr_prom, "Prime Status", :prime_status
    rename_column :carr_prom, "MC#", :mc_number
    rename_column :carr_prom, "Owner", :owner
    #CarrDemo
    rename_column :carr_demo, "Carrier_Name", :carrier_name
    rename_column :carr_demo, "Current_Tier", :current_tier
    rename_column :carr_demo, "Previous_Tier", :previous_tier
    rename_column :carr_demo, "Highest_Tier", :highest_tier
    rename_column :carr_demo, "Highest_Tier_Date", :highest_tier_date
    rename_column :carr_demo, "Gross_Margin_%", :gross_margin
    rename_column :carr_demo, "Load_Last_Week", :load_last_week
    rename_column :carr_demo, "Load_Last_Month", :load_last_month
    rename_column :carr_demo, "Load_Last_3_Months", :load_last_3_months
    rename_column :carr_demo, "Load_Last_6_Months", :load_last_6_months
    rename_column :carr_demo, "Phone#1", :phone1
    rename_column :carr_demo, "Phone#2", :phone2
    rename_column :carr_demo, "Prime Status", :prime_status
    rename_column :carr_demo, "MC#", :mc_number
    rename_column :carr_demo, "Owner", :owner
    rename_column :carr_demo, "Days_Since", :days_since
    #McLatestDate
    rename_column :mc_latest_date, "Tier", :tier
  end
end
