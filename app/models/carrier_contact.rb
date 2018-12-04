class CarrierContact < ApplicationRecord
  audited
  def location
    begin
      CarrierLocation.find(self.location_id)
    rescue
      nil
    end
  end
  def display_name
    if self.carrier.nil?
      "<a href='/carrier_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.carrier.display_name}"
    end
  end
  def carrier
    begin
      Carrier.find(self.carrier_id)
    rescue
      nil
    end
  end
  def full_name
    (self.first_name.nil? ? '' : self.first_name) + " " + (self.last_name.nil? ? '' : self.last_name)
  end
end
