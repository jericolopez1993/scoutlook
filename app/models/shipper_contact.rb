class ShipperContact < ApplicationRecord
  audited
  belongs_to :shipper_location, foreign_key: 'location_id', optional: true
  belongs_to :shipper, optional: true
  has_one :user, primary_key: "id", foreign_key: 'carrier_contact_id'

  def display_name
    if self.shipper.nil?
      "<a href='/shipper_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.shipper.display_name}"
    end
  end

  def full_name
    (self.first_name.nil? ? '' : self.first_name.capitalize) + " " + (self.last_name.nil? ? '' : self.last_name.capitalize)
  end

end
