class Message < ApplicationRecord
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  scope :inboxes, -> {where(:inbox => true)}
  scope :sents, -> {where(:sent => true)}
  scope :trashes, -> {where(:trash => true)}
  scope :archives, -> {where(:archive => true)}

  def get_company_name
    if self.carrier
      self.carrier.company_name
    elsif self.shipper
      self.shipper.company_name
    else
      nil
    end
  end
end
