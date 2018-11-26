class Carrier < ApplicationRecord
  audited
  has_many_attached :attachment_file
  after_destroy :remove_children


  def display_name
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "Carrier (<a href='/carriers/#{self.id}'>#{self.company_name}</a>)"
    else
      "<a href='/carriers/#{self.id}'>Carrier</a>"
    end
  end

  def rep
    begin
      Rep.find(self.relationship_owner)
    rescue
      nil
    end
  end

  def carrier_lanes
    CarrierLane.where(:carrier_id => self.id)
  end

  def default_location
      if !self.origin.nil?
        CarrierLocation.find(self.origin).location
      elsif !self.head_office.nil?
        CarrierLocation.find(self.head_office).location
      elsif CarrierLocation.all.length > 0
        CarrierLocation.first.location
      else
        nil
      end
  end

  def origin_location
    begin
      CarrierLocation.find(self.origin)
    rescue
      nil
    end
  end

  def destination_location
    begin
      CarrierLocation.find(self.destination)
    rescue
      nil
    end
  end

  def head_office_location
    begin
      Location.find(self.head_office)
    rescue
      nil
    end
  end

  def location
    begin
      Location.find(self.head_office)
    rescue
      nil
    end
  end

  def is_inbound?(location_id)
    CarrierLocation.where(:carrier_id => self.id, :location_id => location_id).length > 0
  end


  private
    def remove_children
      CarrierContact.where(:carrier_id => self.id).destroy_all
      CarrierLocation.where(:carrier_id => self.id).destroy_all
    end
end
