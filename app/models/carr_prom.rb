class CarrProm < ApplicationRecord
  self.table_name = "carr_prom"

  scope :listings, -> {select('carr_prom.*, (SELECT id FROM carriers WHERE mc_number = carr_prom."MC#" LIMIT 1) AS carrier_id')}

  default_scope {listings}

end
