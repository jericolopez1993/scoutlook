class Shipment < ApplicationRecord

  def origin
    if !self.origin_id.nil?
      Client.find(self.origin_id)
    else
      nil
    end
  end
  def origin_location
    if !self.origin_location_id.nil?
      ClientLocation.find(self.origin_location_id)
    else
      nil
    end
  end
  def destination
    if !self.destination_id.nil?
      Client.find(self.destination_id)
    else
      nil
    end
  end
  def destination_location
    if !self.destination_location_id.nil?
      ClientLocation.find(self.destination_location_id)
    else
      nil
    end
  end
end
