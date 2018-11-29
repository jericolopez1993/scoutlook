class CarrierLocation < ApplicationRecord
  audited
  def display_name
    if self.carrier.nil?
      "Location"
    else
      "Location to #{self.carrier.display_name}"
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
