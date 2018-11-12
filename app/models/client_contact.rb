class ClientContact < ApplicationRecord
  audited
  def location
    if !self.location_id.nil?
      Location.find(self.location_id)
    else
      nil
    end
  end
end
