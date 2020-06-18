class MasterInvoice < ApplicationRecord
  include Auditable only: [:own_status]
  has_one_attached :attachment_file
  def display_name
      if self.invoice_number.present? && self.invoice_number != "" && !self.invoice_number.nil?
        "Invoice (<a href='/invoices/#{self.id}'>#{self.invoice_number}</a>)"
      else
        "<a href='/invoices/#{self.id}'>Invoice</a>"
      end

  end
  def shipper
    begin
      Client.find(self.shipper_id)
    rescue
      nil
    end

  end
  def carrier
    begin
      Client.find(self.carrier_id)
    rescue
      nil
    end

  end

  def shipment
    if self.shipment_entry == 'Single'
      shipments = Shipment.where(:header => self.id)
      if shipments.present? && !shipments.nil?
        shipments.first
      else
        nil
      end
    else
      nil
    end
  end

  def child_total_charge
    Shipment.where(:header => self.id).sum(:total_charge)
  end

  def child_total_charge_with_tax
    Shipment.where(:header => self.id).sum(:total_charge_with_tax)
  end

  def shipper_location
    begin
      Client.find(self.shipper_id).default_location
    rescue
      nil
    end
  end
end
