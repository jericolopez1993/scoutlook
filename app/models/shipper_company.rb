class ShipperCompany < ApplicationRecord
  belongs_to :shipper, optional: true
end
