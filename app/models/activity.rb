class Activity < ApplicationRecord
  audited
  has_many_attached :proposal_pdf
  has_one_attached :credit_application
  before_save :set_open_and_close_date
  belongs_to :carrier_contact, optional: true
  belongs_to :shipper_contact, optional: true
  belongs_to :user, optional: true
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true

  def display_name
    if self.carrier.nil?
      "Carrier Activity to #{self.carrier.display_name}"
    elsif self.shipper.nil?
      "Shipper Activity to #{self.shipper.display_name}"
    else
      "<a href='/activities/#{self.id}'>Activity</a>"
    end
  end

  def set_open_and_close_date
    if self.status
      self.date_opened = Time.now.getutc
    else
      self.date_closed = Time.now.getutc
    end
  end


end
