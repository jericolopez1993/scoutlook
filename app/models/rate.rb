class Rate < ApplicationRecord
  audited
  has_one_attached :supporting_pdf
  belongs_to :user, optional: true
  belongs_to :activity, optional: true
  belongs_to :parent, class_name: "Rate", foreign_key: "parent_id", optional: true
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  belongs_to :carrier_contact, optional: true
  belongs_to :shipper_contact, optional: true

  def display_name
    if self.carrier.nil?
      "<a href='/rates/#{self.id}'>Rate</a>"
    else
      "Rate to #{self.carrier.display_name}"
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
