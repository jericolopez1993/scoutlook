class ClientContact < ApplicationRecord
  audited
  def location
    begin
      Location.find(self.location_id)
    rescue
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
    begin
      Client.find(self.client_id)
    rescue
      nil
    end
  end
end
