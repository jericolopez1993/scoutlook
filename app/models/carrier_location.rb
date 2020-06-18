class CarrierLocation < ApplicationRecord
  include Auditable
  belongs_to :carrier, optional: true

  def display_name
    if self.carrier.nil?
      "Location"
    else
      "Location to #{self.carrier.display_name}"
    end
  end
end
