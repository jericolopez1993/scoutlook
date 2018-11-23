class Rate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  def display_name
    if self.client.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Rate to #{self.client.display_name}"
    end
  end
  def rep
    if !self.rep_id.nil?
      Rep.find(self.rep_id)
    else
      nil
    end
  end
  def client
    if !self.client_id.nil?
      Client.find(self.client_id)
    else
      nil
    end
  end
  def parent
    if !self.parent_id.nil?
      Rate.find(self.parent_id)
    else
      nil
    end
  end

  def origin_location
    if !self.origin_location_id.nil?
      Location.find(self.origin_location_id)
    else
      nil
    end
  end

  def destination_location
    if !self.destination_location_id.nil?
      Location.find(self.destination_location_id)
    else
      nil
    end
  end

end
