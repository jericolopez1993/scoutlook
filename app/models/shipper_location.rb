class ShipperLocation < ApplicationRecord
  audited
  def display_name
    if self.shipper.nil?
      "Location"
    else
      "<a href='/shipper_locations/#{self.id}'>Location</a>"
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
