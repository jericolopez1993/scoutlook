class CarrierCompany < ApplicationRecord
  belongs_to :carrier, optional: true
end
