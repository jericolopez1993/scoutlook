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
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 1).first
  end

  def lane_2
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 2).first
  end

  def lane_3
    ShipperLane.where(:shipper_id => self.id, :lane_priority => 3).first
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


  private
    def remove_children
      ShipperContact.where(:shipper_id => self.id).destroy_all
      ShipperLocation.where(:shipper_id => self.id).destroy_all
    end
end
