class Carrier < ApplicationRecord
  audited
  before_save :approved?
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

  def carrier_setup_rep
    begin
      Rep.find(self.carrier_setup)
    rescue
      nil
    end
  end

  def locations
    CarrierLocation.where(:carrier_id => self.id)
  end

  def carrier_lanes
    CarrierLane.where(:carrier_id => self.id)
  end

  def carrier_activities
    CarrierActivity.where(:carrier_id => self.id)
  end

  def lane_1
    CarrierLane.where(:carrier_id => self.id, :lane_priority => 1)
  end

  def lane_2
    CarrierLane.where(:carrier_id => self.id, :lane_priority => 2)
  end

  def lane_3
    CarrierLane.where(:carrier_id => self.id, :lane_priority => 3)
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
      CarrierLocation.find(self.head_office)
    rescue
      nil
    end
  end

  def location
    begin
      CarrierLocation.find(self.head_office)
    rescue
      nil
    end
  end

  def is_inbound?(location_id)
    CarrierLocation.where(:carrier_id => self.id, :location_id => location_id).length > 0
  end

  def poc
    if self.poc_id.present? && !self.poc_id.nil?
      CarrierContact.find(self.poc_id)
    else
      nil
    end
  end

  def pdm
    if self.pdm_id.present? && !self.pdm_id.nil?
      CarrierContact.find(self.pdm_id)
    else
      nil
    end
  end

  def adm
    CarrierContact.where(:carrier_id => self.id, :adm => true).order("id DESC")
  end

  def last_contact_by_rep
    if self.last_contact_by.present? && !self.last_contact_by.nil?
      Rep.find(self.last_contact_by)
    else
      nil
    end
  end
  def last_contact_date
    CarrierActivity.where(:carrier_id => self.id).last
  end


  private
    def remove_children
      CarrierContact.where(:carrier_id => self.id).destroy_all
      CarrierLocation.where(:carrier_id => self.id).destroy_all
    end

    def approved?
      if self.approved
        self.date_approved = Date.today
      end
    end
end
