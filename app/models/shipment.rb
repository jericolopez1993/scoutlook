class Shipment < ApplicationRecord
  audited only: [:shipment_status]
  has_one_attached :shipment_attachment_file
  def display_name
    if self.invoice.nil?
      "Shipment to #{self.invoice.display_name}"
    else
      "<a href='/shipments/#{self.id}'>Shipment</a>"
    end
  end
  def origin_location
    if !self.origin_location_id.nil?
      begin
        Location.find(self.origin_location_id)
      rescue
        nil
      end
    else
      nil
    end
  end

  def destination_location
    if !self.destination_location_id.nil?
      begin
        Location.find(self.destination_location_id)
      rescue
        nil
      end
    else
      nil
    end
  end

  def invoice
    if !self.header.nil?
      MasterInvoice.find(self.header)
    else
      nil
    end
  end

  def shipper
    if !self.header.nil?
      MasterInvoice.find(self.header).shipper
    else
      nil
    end
  end

  def shipper_location
    if !self.header.nil?
      MasterInvoice.find(self.header).shipper_location
    else
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
