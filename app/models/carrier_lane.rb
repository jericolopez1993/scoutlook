class CarrierLane < ApplicationRecord
  audited
  def display_name
    if self.carrier.nil?
      "Lane"
    else
      "Lane to #{self.carrier.display_name}"
    end
  end
  
  def lane_priority_display
    ['', 'High', 'Medium', 'Low'][self.lane_priority || 0]
  end

  def carrier
    begin
      Carrier.find(self.carrier_id)
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
