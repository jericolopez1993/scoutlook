class CarrierContact < ApplicationRecord
  audited
  belongs_to :carrier_location, foreign_key: 'location_id', optional: true
  belongs_to :carrier, optional: true

  def display_name
    if self.carrier.nil?
      "<a href='/carrier_contacts/#{self.id}'>Contact</a>"
    else
      "Contact to #{self.carrier.display_name}"
    end
  end

  def full_name
    (self.first_name.nil? ? '' : self.first_name) + " " + (self.last_name.nil? ? '' : self.last_name)
  end

  def user
    begin
      User.where(:carrier_contact_id => self.id).first
    rescue
      nil
    end
  end
end
