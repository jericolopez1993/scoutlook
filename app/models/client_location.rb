class ClientLocation < ApplicationRecord
  # before_create :set_location_id
  #
  # def set_location_id
  #   count = (ClientLocation.all.length + 1).to_s.rjust(5, '0')
  #   self.location_id = "ENG" + count
  # end
end
