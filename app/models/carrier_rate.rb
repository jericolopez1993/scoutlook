class CarrierRate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  belongs_to :user, optional: true
  belongs_to :carrier, optional: true

  def display_name
    if self.carrier.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Carrier Rate to #{self.carrier.display_name}"
    end
  end

  def parent
    begin
      CarrierRate.find(self.parent_id)
    rescue
      nil
    end
  end
end
