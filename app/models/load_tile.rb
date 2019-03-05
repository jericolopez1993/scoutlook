class LoadTile < ApplicationRecord
  belongs_to :tile_tab, optional: true
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :salesperson, class_name: "User", foreign_key: "salesperson_id", optional: true
  belongs_to :truck_tile, optional: true

  def display_name
    "#{self.origin} &rarr; #{self.destination}".html_safe
  end

  def origin_to_array
    if self.origin.nil?
      []
    else
      self.origin.split(',').map(&:to_s)
    end
  end

  def destination_to_array
    if self.destination.nil?
      []
    else
      self.destination.split(',').map(&:to_s)
    end
  end

  def uniq_id
    "L-#{self.id}"
  end

  def location_with_uniq_id
    "#{self.uniq_id} #{self.shipper && '& ' + self.shipper.company_name.gsub(/[^0-9A-Za-z]/, '')[0, 10].upcase} & #{self.origin} - #{self.destination}"
  end
end
