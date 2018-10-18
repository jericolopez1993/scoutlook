class Shipment < ApplicationRecord

  def origin_location
    if !self.origin_location_id.nil?
      Location.find(self.origin_location_id)
    else
      nil
    end
  end
  
  def destination_location
    if !self.destination_location_id.nil?
      Location.find(self.destination_location_id)
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
end
