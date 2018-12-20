class ShipperRate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  def display_name
    if self.shipper.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Shipper Rate to #{self.shipper.display_name}"
    end
  end
  def user
    begin
      User.find(self.user_id)
    rescue
      nil
    end
  end
  def shipper
    begin
      Shipper.find(self.shipper_id)
    rescue
      nil
    end
  end
  def parent
    begin
      ShipperRate.find(self.parent_id)
    rescue
      nil
    end
  end
end
