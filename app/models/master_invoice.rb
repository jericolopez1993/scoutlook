class MasterInvoice < ApplicationRecord

  def shipper
    if !self.shipper_id.nil?
      Client.find(self.shipper_id)
    else
      nil
    end
  end
  def carrier
    if !self.carrier_id.nil?
      Client.find(self.carrier_id)
    else
      nil
    end
  end
end
