class CarrierRate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  def display_name
    if self.carrier.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Carrier Rate to #{self.carrier.display_name}"
    end
  end
  def rep
    begin
      Rep.find(self.rep_id)
    rescue
      nil
    end
  end
  def carrier
    begin
      Carrier.find(self.carrier_id)
    rescue
      nil
    end
  end
  def parent
    begin
      CarrierRate.find(self.parent_id)
    rescue
      nil
    end
  end

  def origin_location
    begin
      CarrierLocation.find(self.origin_location_id)
    rescue
      nil
    end
  end

  def destination_location
    begin
      CarrierLocation.find(self.destination_location_id)
    rescue
      nil
    end
  end

end
