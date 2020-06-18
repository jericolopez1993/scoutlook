class ShipperLocation < ApplicationRecord
  include Auditable
  belongs_to :shipper, optional: true
  def display_name
    if self.shipper.nil?
      "Location"
    else
      "Location to #{self.shipper.display_name}"
    end
  end
  def shipping_day_to_array
    if self.shipping_day.nil?
      []
    else
      self.shipping_day.split(',').map(&:to_s)
    end
  end
  def receiving_day_to_array
    if self.receiving_day.nil?
      []
    else
      self.receiving_day.split(',').map(&:to_s)
    end
  end
end
