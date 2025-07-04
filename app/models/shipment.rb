class Shipment < ApplicationRecord
  include Auditable
  has_one_attached :shipment_attachment_file
  def display_name
    if self.invoice.nil?
      "Shipment to #{self.invoice.display_name}"
    else
      "<a href='/shipments/#{self.id}'>Shipment</a>"
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

  def invoice
    begin
      MasterInvoice.find(self.header)
    rescue
      nil
    end
  end

  def shipper
    begin
      MasterInvoice.find(self.header).shipper
    rescue
      nil
    end
  end

  def shipper_location
    begin
      MasterInvoice.find(self.header).shipper_location
    rescue
      nil
    end
  end

  def convert_to_lb
    weight = self.billed_weight.nil? ? 0 : self.billed_weight
    if !self.unit_of_weight.nil? && self.unit_of_weight != ''
      if self.unit_of_weight == 'kg'
        weight * 2.20462
      else
        weight
      end
    else
      weight
    end
  end
end
