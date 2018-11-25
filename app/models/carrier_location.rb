class CarrierLocation < ApplicationRecord
  # before_create :set_location_id
  #
  # def set_location_id
  #   count = (CarrierLocation.all.length + 1).to_s.rjust(5, '0')
  #   self.location_id = "ENG" + count
  # end

  def location
    if !self.location_id.nil?
      Location.find(self.location_id)
    else
      nil
    end
  end
end
