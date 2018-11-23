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
    begin
      Rep.find(self.rep_id)
    rescue
      nil
    end
  end
  def client
    begin
      Client.find(self.client_id)
    rescue
      nil
    end
  end
  def parent
    begin
      Rate.find(self.parent_id)
    rescue
      nil
    end
  end

  def origin_location
    begin
      Location.find(self.origin_location_id)
    rescue
      nil
    end
  end

  def destination_location
    begin
      Location.find(self.destination_location_id)
    rescue
      nil
    end
  end

end
