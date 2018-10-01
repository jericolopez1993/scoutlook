# t.string "client_type"
# t.integer "relationship_owner"
# t.string "company_name"
# t.string "client_id"
# t.string "parent_id"
# t.integer "sales_priority"
# t.string "address"
# t.string "city"
# t.string "state"
# t.string "postal"
# t.string "country"
# t.string "phone"
# t.decimal "annual_revenue"
# t.string "industry"
# t.string "primary_industry"
# t.string "hazardous"
# t.string "food_grade"
# t.decimal "freight_revenue"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

class Client < ApplicationRecord
  has_many_attached :attachment_file
  # before_create :set_client_id
  #
  # def set_client_id
  #   count = (Client.all.length + 1).to_s.rjust(5, '0')
  #   self.client_id = "LOOP" + count
  # end
end
