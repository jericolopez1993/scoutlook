class Carrier < ApplicationRecord
  audited
  before_save :approved?
  has_many_attached :attachment_file
  after_destroy :remove_children

  belongs_to :relationship_owner_user, class_name: "User", foreign_key: "relationship_owner", optional: true
  belongs_to :carrier_setup_user, class_name: "User", foreign_key: "carrier_setup", optional: true

  has_many :locations, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierLocation"
  has_many :carrier_lanes, :dependent => :delete_all
  has_many :lane_1, -> { where(lane_priority: 1)}, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierLane"
  has_many :lane_2, -> { where(lane_priority: 2)}, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierLane"
  has_many :lane_3, -> { where(lane_priority: 3)}, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierLane"
  has_many :activities, :dependent => :destroy
  has_many :rates, :dependent => :delete_all
  has_many :adm, -> { where(adm: true).order("id DESC")}, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierContact"
  has_many :carrier_contacts, :dependent => :delete_all
  has_many :reminders, :dependent => :delete_all
  has_many :carrier_companies, :dependent => :delete_all

  has_one :origin_location, primary_key: "origin", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :destination_location, primary_key: "destination", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :head_office_location, primary_key: "head_office", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :location, primary_key: "head_office", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :poc, primary_key: "poc_id", foreign_key: 'id', class_name: "CarrierContact"
  has_one :pdm, primary_key: "pdm_id", foreign_key: 'id', class_name: "CarrierContact"

  scope :listings, -> {select("carriers.*, carrier_contacts.primary_phone, carrier_contacts.primary_phone_type, carrier_contacts.primary_extension_number, carrier_contacts.primary_eligible_texting, carrier_contacts.secondary_phone, carrier_contacts.secondary_phone_type, carrier_contacts.secondary_extension_number, carrier_contacts.secondary_eligible_texting, carrier_contacts.email as contact_email, carrier_locations.city, carrier_locations.address, carrier_locations.state, carrier_locations.country, carrier_locations.loc_type, (SELECT id FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) AS lane_id, (SELECT lane_destination FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_destination, (SELECT lane_origin FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_origin, (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened, CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name, CONCAT(carrier_setup_user.first_name, ' ', carrier_setup_user.last_name) as carrier_setup_name, CONCAT(carrier_contacts.first_name, ' ', carrier_contacts.last_name) as poc_name, (SELECT created_at FROM audits WHERE ((auditable_type = 'Carrier' AND auditable_id IN (carriers.id)) OR (auditable_type = 'CarrierCompany' AND auditable_id IN (SELECT id FROM carrier_companies WHERE carrier_companies.carrier_id = carriers.id)) OR (auditable_type = 'CarrierContact' AND auditable_id IN (SELECT id FROM carrier_contacts WHERE carrier_contacts.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLane' AND auditable_id IN (SELECT id FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLocation' AND auditable_id IN (SELECT id FROM carrier_locations WHERE carrier_locations.carrier_id = carriers.id)) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT id FROM activities WHERE activities.carrier_id = carriers.id)) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT id FROM rates WHERE rates.carrier_id = carriers.id)) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT id FROM reminders WHERE reminders.carrier_id = carriers.id))) ORDER BY created_at DESC LIMIT 1) AS last_activity_date, (SELECT campaign_name FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name, (SELECT activity_type FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_type, (SELECT status FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_status").joins("INNER JOIN users AS carrier_setup_user ON carrier_setup_user.id = carriers.carrier_setup").joins("INNER JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner").joins("INNER JOIN carrier_locations ON carrier_locations.id = carriers.head_office").joins("INNER JOIN carrier_contacts ON carrier_contacts.id = carriers.poc_id")}

  scope :overall, ->(id) {where(:id => id).select("carriers.*, carrier_contacts.primary_phone, carrier_contacts.primary_phone_type, carrier_contacts.primary_extension_number, carrier_contacts.primary_eligible_texting, carrier_contacts.secondary_phone, carrier_contacts.secondary_phone_type, carrier_contacts.secondary_extension_number, carrier_contacts.secondary_eligible_texting, carrier_contacts.email as contact_email, carrier_locations.city, carrier_locations.address, carrier_locations.state, carrier_locations.country, carrier_locations.loc_type, (SELECT id FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) AS lane_id, (SELECT lane_destination FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_destination, (SELECT lane_origin FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id ORDER BY lane_priority DESC, created_at DESC LIMIT 1) as lane_origin, (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened, CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name, CONCAT(carrier_setup_user.first_name, ' ', carrier_setup_user.last_name) as carrier_setup_name, CONCAT(carrier_contacts.first_name, ' ', carrier_contacts.last_name) as poc_name, (SELECT created_at FROM audits WHERE ((auditable_type = 'Carrier' AND auditable_id IN (carriers.id)) OR (auditable_type = 'CarrierCompany' AND auditable_id IN (SELECT id FROM carrier_companies WHERE carrier_companies.carrier_id = carriers.id)) OR (auditable_type = 'CarrierContact' AND auditable_id IN (SELECT id FROM carrier_contacts WHERE carrier_contacts.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLane' AND auditable_id IN (SELECT id FROM carrier_lanes WHERE carrier_lanes.carrier_id = carriers.id)) OR (auditable_type = 'CarrierLocation' AND auditable_id IN (SELECT id FROM carrier_locations WHERE carrier_locations.carrier_id = carriers.id)) OR (auditable_type = 'Activity' AND auditable_id IN (SELECT id FROM activities WHERE activities.carrier_id = carriers.id)) OR (auditable_type = 'Rate' AND auditable_id IN (SELECT id FROM rates WHERE rates.carrier_id = carriers.id)) OR (auditable_type = 'Reminder' AND auditable_id IN (SELECT id FROM reminders WHERE reminders.carrier_id = carriers.id))) ORDER BY created_at DESC LIMIT 1) AS last_activity_date, (SELECT campaign_name FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name, (SELECT activity_type FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_type, (SELECT status FROM activities WHERE carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_status").joins("INNER JOIN users AS carrier_setup_user ON carrier_setup_user.id = carriers.carrier_setup").joins("INNER JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner").joins("INNER JOIN carrier_locations ON carrier_locations.id = carriers.head_office").joins("INNER JOIN carrier_contacts ON carrier_contacts.id = carriers.poc_id").limit(1)}

  default_scope {listings}

  BLUE = ["NY", "NY-Brooklyn", "NY-Bronx",]
  LIGHT_BLUE = ["AL", "AK", "AR", "CO", "CT", "DE", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
  "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NJ", "NV", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD",
  "TN", "UT", "VT", "VA", "WV", "WI", "WY",]
  DARK_BLUE = ["US-Northeast", "US-Northeast (No Bronx)", "US-Southeast", "US-Northwest", "US-Midwest",]
  BROWN = ["TX", "TX-McAllen"]
  ORANGE = ["CA", "CA-Fresno", "CA-Bakersfield", "AZ", "AZ-Yuma",]
  YELLOW = ["FL",]
  GREEN = ["WA",]
  RED = ["BC", "AB", "SK", "MB", "ON", "QC", "NB", "NS", "PEI", "NL", "NU",
  "NT", "YK",]

  def display_name
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "Carrier (<a href='/carriers/#{self.id}'>#{self.company_name}</a>)"
    else
      "<a href='/carriers/#{self.id}'>Carrier</a>"
    end
  end

  def is_inbound?(location_id)
    CarrierLocation.where(:carrier_id => self.id, :location_id => location_id).length > 0
  end

  def last_contact_date
    Activity.where(:carrier_id => self.id).last
  end

  def rates
    activity_ids = self.activities.distinct(:id).pluck(:id).map(&:inspect).join(',')
    rates_carrier = Rate.where(carrier_id: self.id)
    if activity_ids != '' && rates_carrier.present?
      Rate.where("activity_id IN (#{activity_ids})").or(Rate.where(carrier_id: self.id))
    elsif activity_ids != '' && rates_carrier.blank?
      Rate.where("activity_id IN (#{activity_ids})")
    elsif activity_ids == '' && rates_carrier.present?
      Rate.where(carrier_id: self.id)
    else
      []
    end
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
