class Location < ApplicationRecord
  audited
  def display_name
    if self.client.nil? && self.carrier.nil?
      "Location"
    else
      "<a href='/locations/#{self.id}'>Location</a>"
    end
  end
  def client
    begin
      Client.find(self.client_id)
    rescue
      nil
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
