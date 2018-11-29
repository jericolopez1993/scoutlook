class ShipperLocation < ApplicationRecord
  audited
  def display_name
    if self.shipper.nil?
      "Location"
    else
      "Location to #{self.shipper.display_name}"
    end
  end
  def shipper
    begin
      Shipper.find(self.shipper_id)
    rescue
      nil
    end
  end
end
