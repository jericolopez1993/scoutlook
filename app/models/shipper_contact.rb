class ShipperContact < ApplicationRecord
  audited
  def location
    begin
      Location.find(self.location_id)
    rescue
      nil
    end
  end
  def display_name
    if self.shipper.nil?
      "<a href='/shipper_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.shipper.display_name}"
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
