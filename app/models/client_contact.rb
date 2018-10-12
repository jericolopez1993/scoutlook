class ClientContact < ApplicationRecord
  def location
    if !self.location_id.nil?
      Location.find(self.location_id)
    else
      nil
    end
  end
end
