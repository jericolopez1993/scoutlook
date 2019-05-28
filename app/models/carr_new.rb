class CarrNew < ApplicationRecord
  self.table_name = "carr_new"

  scope :listings, -> {select('carr_new.*, (SELECT id FROM carriers WHERE mc_number = carr_new."MC#" LIMIT 1) AS carrier_id')}

  default_scope {listings}
end
