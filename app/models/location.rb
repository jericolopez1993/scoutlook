class Location < ApplicationRecord
  audited
  def display_name
    if self.client.nil?
      "Location to #{self.client.display_name}"
    else
      "<a href='/locations/#{self.id}'></a>)"
    end
  end
  def client
    if !self.client_id.nil?
      Client.find(self.client_id)
    else
      nil
    end
  end
end
