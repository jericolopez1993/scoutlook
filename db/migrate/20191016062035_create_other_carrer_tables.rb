class CreateOtherCarrerTables < ActiveRecord::Migration[5.2]
  def change
    if !table_exists?(:carr_new)
      create_table :carr_new  do |t|
        t.text "Carrier_Name"
        t.text "Contact"
        t.text "Load_Last_Month"
        t.datetime "First_Load_Date"
        t.datetime "Last_Load_Date"
        t.text "Last_OS"
        t.text "Last_DS"
        t.text "Gross_Margin_%"
        t.text "mcnum"
        t.integer "Loads_LW"
        t.integer "Loads_2W"
        t.integer "Loads_3W"
        t.integer "Loads_4W"
        t.text "Phone#1"
        t.text "Phone#2"
        t.text "Prime Status"
        t.text "MC#"
        t.text "Owner"
      end
    end
    if !table_exists?(:carr_prom)
      create_table :carr_prom  do |t|
        t.text "Carrier_Name"
        t.text "Current_Tier"
        t.text "Previous_Tier"
        t.text "Highest_Tier"
        t.date "Highest_Tier_Date"
        t.text "Gross_Margin_%"
        t.decimal "Load_Last_Week"
        t.decimal "Load_Last_Month"
        t.decimal "Load_Last_3_Months"
        t.decimal "Load_Last_6_Months"
        t.text "mcnum"
        t.text "Highest_Tier_Reached"
        t.text "Phone#1"
        t.text "Phone#2"
        t.text "Prime Status"
        t.text "MC#"
        t.text "Owner"
      end
    end
    if !table_exists?(:carr_demo)
      create_table :carr_demo  do |t|
        t.text "Carrier_Name"
        t.text "Current_Tier"
        t.text "Previous_Tier"
        t.text "Highest_Tier"
        t.date "Highest_Tier_Date"
        t.text "Gross_Margin_%"
        t.decimal "Load_Last_Week"
        t.decimal "Load_Last_Month"
        t.decimal "Load_Last_3_Months"
        t.decimal "Load_Last_6_Months"
        t.text "mcnum"
        t.text "Phone#1"
        t.text "Phone#2"
        t.text "Prime Status"
        t.text "MC#"
        t.text "Owner"
        t.integer "Days_Since"
      end
    end
    if !table_exists?(:mc_latest_date)
      create_table :mc_latest_date  do |t|
        t.text "mcnum"
        t.datetime "ship_date_1"
        t.decimal "loadsh_num"
        t.decimal "loadsh_num_6mon"
        t.text "Tier"
      end
    end
  end
end
