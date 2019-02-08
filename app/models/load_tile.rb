class LoadTile < ApplicationRecord
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
end
