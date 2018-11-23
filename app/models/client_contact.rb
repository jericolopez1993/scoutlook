class ClientContact < ApplicationRecord
  audited
  def location
    if !self.location_id.nil?
      Location.find(self.location_id)
    else
      nil
    end
  end
  def display_name
    if self.client.nil?
      "<a href='/client_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.client.display_name}"
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
