# t.string "client_type"
# t.integer "relationship_owner"
# t.string "company_name"
# t.string "client_id"
# t.string "parent_id"
# t.integer "sales_priority"
# t.string "address"
# t.string "city"
# t.string "state"
# t.string "postal"
# t.string "country"
# t.string "phone"
# t.decimal "annual_revenue"
# t.string "industry"
# t.string "primary_industry"
# t.string "hazardous"
# t.string "food_grade"
# t.decimal "freight_revenue"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false

class Client < ApplicationRecord
  audited
  has_many_attached :attachment_file
  after_destroy :remove_children
  # before_create :set_client_id
  #
  # def set_client_id
  #   count = (Client.all.length + 1).to_s.rjust(5, '0')
  #   self.client_id = "LOOP" + count
  # end
  def rep
    if !self.relationship_owner.nil?
      Rep.find(self.relationship_owner)
    else
      nil
    end
  end

  def default_location
      if !self.origin.nil?
        ClientLocation.find(self.origin).location
      elsif !self.head_office.nil?
        ClientLocation.find(self.head_office).location
      elsif ClientLocation.all.length > 0
        ClientLocation.first.location
      else
        nil
      end
  end

  def origin_location
    if !self.origin.nil?
      ClientLocation.find(self.origin)
    else
      nil
    end
  end

  def destination_location
    if !self.destination.nil?
      ClientLocation.find(self.destination)
    else
      nil
    end
  end

  def head_office_location
    if !self.head_office.nil?
      Location.find(self.head_office)
    else
      nil
    end
  end

  def shipments
    client_locations = Location.where(:client_id => self.id)
    if client_locations.length > 0
      client_location_ids = client_locations.distinct(:id).pluck(:id).map(&:inspect).join(',')
      if client_location_ids != ''
        Shipment.where("origin_location_id IN (#{client_location_ids}) OR destination_location_id IN (#{client_location_ids})")
      else
        nil
      end
    else
      nil
    end
  end

  def location
    if !self.head_office.nil?
      Location.find(self.head_office)
    else
      nil
    end
  end


  def master_invoices
    MasterInvoice.where("shipper_id = #{self.id} OR carrier_id = #{self.id}")
  end

  def is_inbound?(location_id)
    ClientLocation.where(:client_id => self.id, :location_id => location_id).length > 0
  end


  private
    def remove_children
      ClientContact.where(:client_id => self.id).destroy_all
      ClientLocation.where(:client_id => self.id).destroy_all
    end
end
