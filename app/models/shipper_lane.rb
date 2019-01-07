class ShipperLane < ApplicationRecord
  audited
  belongs_to :shipper, optional: true

  ORIGINS = [
    ['Canada', [
      "CAN-BC", "CAN-AB", "CAN-SK", "CAN-MB", "CAN-ON", "CAN-QC", "CAN-NB", "CAN-NS", "CAN-PEI", "CAN-NL", "CAN-NU",
      "CAN-NT", "CAN-YK",
    ]],
    ['United States', [
      "US-AL", "US-AK", "US-AZ", "US-AR", "US-CA", "US-CO", "US-CT", "US-DE", "US-FL", "US-GA", "US-HI", "US-ID",
      "US-IL", "US-IN", "US-IA", "US-KS", "US-KY", "US-LA", "US-ME", "US-MD", "US-MA", "US-MI", "US-MN", "US-MS",
      "US-MO", "US-MT", "US-NE", "US-NV", "US-NC", "US-ND", "US-OH", "US-OK", "US-OR", "US-PA", "US-RI", "US-SC",
      "US-SD", "US-TN", "US-TX", "US-UT", "US-VT", "US-VA", "US-WA", "US-WV", "US-WI", "US-WY",
      "US-Northeast", "US-Northeast (No Bronx)", "US-Southeast", "US-Northwest", "US-Midwest",
    ]]
  ]
  DESTINATIONS = ORIGINS
  def display_name
    if self.shipper.nil?
      "Lane"
    else
      "Lane to #{self.shipper.display_name}"
    end
  end

  def lane_priority_display
    ['', 'High', 'Medium', 'Low'][self.lane_priority || 0]
  end

  def preferred_load_day_to_array
    if self.preferred_load_day.nil?
      []
    else
      self.preferred_load_day.split(',').map(&:to_s)
    end
  end
  def preferred_load_day_initials
    if self.preferred_load_day.nil?
      ''
    else
      self.preferred_load_day.split(',').map { |day| ['T', 'S'].include?(day[0]) ? day[0..1] : day[0] }.join(', ')
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
  def commodities_to_array
    if self.commodities.nil?
      []
    else
      self.commodities.split(',').map(&:to_s)
    end
  end
end
