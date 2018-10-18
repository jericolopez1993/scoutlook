class MasterSignal < ApplicationRecord
  def client
    if !self.client_id.nil?
      Client.find(self.client_id)
    else
      nil
    end
  end
  def client_contact
    if !self.client_contact_id.nil?
      ClientContact.find(self.client_contact_id)
    else
      nil
    end
  end
  def rate
    if !self.rate_id.nil?
      Rate.find(self.rate_id)
    else
      nil
    end
  end

  def origin_location
    if !self.origin_location_id.nil?
      Location.find(self.origin_location_id)
    else
      nil
    end
  end

  def destination_location
    if !self.destination_location_id.nil?
      Location.find(self.destination_location_id)
    else
      nil
    end
  end
end
