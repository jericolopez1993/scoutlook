class ShipperLocation < ApplicationRecord
  audited
  belongs_to :shipper, optional: true
  def display_name
    if self.shipper.nil?
      "Location"
    else
      "Location to #{self.shipper.display_name}"
    end
  end
end
