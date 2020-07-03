class CreateSlCarrNews < ActiveRecord::Migration[5.2]
  def change
    create_table :sl_carr_news do |t|
      t.text "carrier_name"
      t.text "contact"
      t.bigint "load_last_month"
      t.datetime "first_load_date"
      t.datetime "last_load_date"
      t.text "last_os"
      t.text "last_ds"
      t.float "gross_margin"
      t.text "mcnum"
      t.bigint "loads_lw"
      t.bigint "loads_2w"
      t.bigint "loads_3w"
      t.bigint "loads_4w"
      t.bigint "loads_5w"
      t.bigint "loads_6w"
      t.text "phone1"
      t.text "phone2"
      t.text "prime status"
      t.text "mc_number"
      t.text "owner"
      t.boolean "is_deleted", default: false
      t.datetime "deleted_at"
      t.timestamps
    end
  end
end
