class ShipperRate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  belongs_to :user, optional: true
  belongs_to :shipper, optional: true

  def display_name
    if self.shipper.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Shipper Rate to #{self.shipper.display_name}"
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
