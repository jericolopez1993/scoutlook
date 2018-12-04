class Shipper < ApplicationRecord
  audited
  has_many_attached :attachment_file
  after_destroy :remove_children


  def display_name
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "Shipper (<a href='/shippers/#{self.id}'>#{self.company_name}</a>)"
    else
      "<a href='/shippers/#{self.id}'>Shipper</a>"
    end
  end

  def rep
    begin
      Rep.find(self.relationship_owner)
    rescue
      nil
    end
  end

  def locations
    ShipperLocation.where(:shipper_id => self.id)
  end

  def shipper_lanes
    ShipperLane.where(:shipper_id => self.id)
  end

  def shipper_activities
    ShipperActivity.where(:shipper_id => self.id)
  end

  def lane_1
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 1)
  end

  def lane_2
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 2)
  end

  def lane_3
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 3)
  end

  def default_location
      if !self.origin.nil?
        ShipperLocation.find(self.origin).location
      elsif !self.head_office.nil?
        ShipperLocation.find(self.head_office).location
      elsif ShipperLocation.all.length > 0
        ShipperLocation.first.location
      else
        nil
      end
  end

  def origin_location
    begin
      ShipperLocation.find(self.origin)
    rescue
      nil
    end
  end

  def destination_location
    begin
      ShipperLocation.find(self.destination)
    rescue
      nil
    end
  end

  def head_office_location
    begin
      ShipperLocation.find(self.head_office)
    rescue
      nil
    end
  end

  def location
    begin
      ShipperLocation.find(self.head_office)
    rescue
      nil
    end
  end

  def is_inbound?(location_id)
    ShipperLocation.where(:shipper_id => self.id, :location_id => location_id).length > 0
  end

  def commodities_to_array
    if self.commodities.nil?
      []
    else
      self.commodities.split(',').map(&:to_s)
    end
  end

  def poc
    if self.poc_id.present? && !self.poc_id.nil?
      ShipperContact.find(self.poc_id)
    else
      nil
    end
  end

  def pdm
    if self.pdm_id.present? && !self.pdm_id.nil?
      ShipperContact.find(self.pdm_id)
    else
      nil
    end
  end

  def last_contact_by_rep
    if self.last_contact_by.present? && !self.last_contact_by.nil?
      Rep.find(self.last_contact_by)
    else
      nil
    end
  end

  private
    def remove_children
      ShipperContact.where(:shipper_id => self.id).destroy_all
      ShipperLocation.where(:shipper_id => self.id).destroy_all
    end
end
