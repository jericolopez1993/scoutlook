class MasterSignal < ApplicationRecord
  audited
  def display_name
    if self.client.nil?
      "<a href='/signals/#{self.id}'>Signal</a>"
    else
      "Signal to #{self.client.display_name}"
    end
  end
  def client
    begin
      Client.find(self.client_id)
    rescue
      nil
    end
  end
  def client_contact
    begin
      ClientContact.find(self.client_contact_id)
    rescue
      nil
    end
  end
  def rate
    begin
      Rate.find(self.rate_id)
    rescue
      nil
    end
  end

  def origin_location
    begin
      Location.find(self.origin_location_id)
    rescue
      nil
    end
  end

  def destination_location
    begin
      Location.find(self.destination_location_id)
    rescue
      nil
    end
  end
end
