class CarrierLane < ApplicationRecord
  audited
  belongs_to :carrier, optional: true
  ORIGINS = [
    ['United States', [
      "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
      "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NJ", "NV", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD",
      "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY",
      "US-Northeast", "US-Northeast (No Bronx)", "US-Southeast", "US-Northwest", "US-Midwest",
    ]],
    ['Canada', [
      "BC", "AB", "SK", "MB", "ON", "QC", "NB", "NS", "PEI", "NL", "NU",
      "NT", "YK",
    ]]
  ]
  DESTINATIONS = ORIGINS
  
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
