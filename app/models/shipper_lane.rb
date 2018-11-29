class ShipperLane < ApplicationRecord
  audited
  def display_name
    if self.shipper.nil?
      "Lane"
    else
      "Lane to #{self.shipper.display_name}"
    end
  end
  def shipper
    begin
      Shipper.find(self.shipper_id)
    rescue
      nil
    end
  end
  def preferred_load_day_to_array
    if self.preferred_load_day.nil?
      []
    else
      self.preferred_load_day.split(',').map(&:to_s)
    end
  end
end
