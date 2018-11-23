class Location < ApplicationRecord
  audited
  def display_name
    if self.client.nil?
      "Location to #{self.client.display_name}"
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
end
