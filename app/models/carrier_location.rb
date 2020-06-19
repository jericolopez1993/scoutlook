class CarrierLocation < ApplicationRecord
  include Auditable
  belongs_to :carrier, optional: true

  def display_name
    if self.carrier_id
      "Location to #{self.carrier.display_name}"
    else
      "Locationsssss"
    end
  end
end
