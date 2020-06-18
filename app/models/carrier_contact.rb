class CarrierContact < ApplicationRecord
  include Auditable
  belongs_to :carrier_location, foreign_key: 'location_id', optional: true
  belongs_to :carrier, optional: true
  has_one :user, primary_key: "id", foreign_key: 'carrier_contact_id'

  def display_name
    if self.carrier.nil?
      "<a href='/carrier_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.carrier.display_name}"
    end
  end

  def full_name
    (self.first_name.nil? ? '' : self.first_name.capitalize) + " " + (self.last_name.nil? ? '' : self.last_name.capitalize)
  end
end
