class CarrierLocation < ApplicationRecord
  audited
  def display_name
    if self.carrier.nil?
      "Location"
    else
      "<a href='/carrier_locations/#{self.id}'>Location</a>"
    end
  end
  def carrier
    begin
      Carrier.find(self.carrier_id)
    rescue
      nil
    end
  end
end
