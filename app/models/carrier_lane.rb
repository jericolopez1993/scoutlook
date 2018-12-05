class CarrierLane < ApplicationRecord
  audited
  ORIGINS = ["US-CAL","US-FL","US-WA","US-TX","US-AZ"]
  DESTINATIONS = ["US-ESB","US-MW","US-SE","US-NW","CAN-BC","CAN-WEST","CAN-ABSK","CAN-ON","CAN-QC","CAN-ATL","CAN-NFL"]
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
  def lane_origin_to_array
    if self.lane_origin.nil?
      []
    else
      self.lane_origin.split(',').map(&:to_s)
    end
  end
  def lane_destination_to_array
    if self.lane_destination.nil?
      []
    else
      self.lane_destination.split(',').map(&:to_s)
    end
  end
end
