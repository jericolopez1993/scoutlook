class CarrDemo < ApplicationRecord
  self.table_name = "carr_demo"

  scope :listings, -> {select('carr_demo.*, (SELECT id FROM carriers WHERE mc_number = carr_demo."MC#" LIMIT 1) AS carrier_id')}

  default_scope {listings}
end
