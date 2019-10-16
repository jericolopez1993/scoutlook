class Carrier < ApplicationRecord
  audited
  before_save :approved?
  has_many_attached :attachment_file
  has_one_attached :interview_attachment_file
  after_destroy :remove_children

  validates_uniqueness_of :mc_number

  belongs_to :relationship_owner_user, class_name: "User", foreign_key: "relationship_owner", optional: true
  belongs_to :carrier_setup_user, class_name: "User", foreign_key: "carrier_setup", optional: true

  has_many :locations, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierLocation"
  has_many :carrier_lanes, :dependent => :delete_all
  has_many :messages, :dependent => :delete_all
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

  scope :listings, -> {select("
    carriers.*,
    (DATE(carriers.created_at) = DATE(CURRENT_DATE - 21)) AS three_weeks_lapse,
    contacts.primary_phone,
    contacts.primary_phone_type,
    contacts.primary_extension_number,
    contacts.primary_eligible_texting,
    contacts.secondary_phone,
    contacts.secondary_phone_type,
    contacts.secondary_extension_number,
    contacts.secondary_eligible_texting,
    contacts.email as contact_email,
    locations.city,
    locations.address,
    locations.state,
    locations.country,
    locations.loc_type,
    carr_new.loads_lw,
    carr_new.loads_2w,
    carr_new.loads_3w,
    carr_new.loads_4w,
    (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened,
    CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name,
    CONCAT(carrier_setup_user.first_name, ' ', carrier_setup_user.last_name) as carrier_setup_name,
    CONCAT(contacts.first_name, ' ', contacts.last_name) as poc_name,
    (SELECT cnactivities.campaign_name FROM activities AS cnactivities WHERE cnactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name,
    (SELECT atactivities.activity_type FROM activities AS atactivities WHERE atactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_type,
    (SELECT sactivities.status FROM activities AS sactivities WHERE sactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_status
    ").joins("
      LEFT JOIN users AS carrier_setup_user ON carrier_setup_user.id = carriers.carrier_setup
    ").joins("
      LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner
    ").joins("
      LEFT JOIN carrier_locations AS locations ON locations.id = carriers.head_office
    ").joins("
      LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id
    ").joins(
      'LEFT JOIN carr_new ON carr_new.mc_number = carriers.mc_number'
    )}

  scope :overall, ->(id) {where(:id => id).select("
    carriers.*,
    (DATE(carriers.created_at) = DATE(CURRENT_DATE - 21)) AS three_weeks_lapse,
    contacts.primary_phone,
    contacts.primary_phone_type,
    contacts.primary_extension_number,
    contacts.primary_eligible_texting,
    contacts.secondary_phone,
    contacts.secondary_phone_type,
    contacts.secondary_extension_number,
    contacts.secondary_eligible_texting,
    contacts.email as contact_email,
    locations.city,
    locations.address,
    locations.state,
    locations.country,
    locations.loc_type,
    carr_new.loads_lw,
    carr_new.loads_2w,
    carr_new.loads_3w,
    carr_new.loads_4w,
    (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened,
    CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name,
    CONCAT(carrier_setup_user.first_name, ' ', carrier_setup_user.last_name) as carrier_setup_name,
    CONCAT(contacts.first_name, ' ', contacts.last_name) as poc_name,
    (SELECT cnactivities.campaign_name FROM activities AS cnactivities WHERE cnactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name,
    (SELECT atactivities.activity_type FROM activities AS atactivities WHERE atactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_type,
    (SELECT sactivities.status FROM activities AS sactivities WHERE sactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_status
    ").joins("
      LEFT JOIN users AS carrier_setup_user ON carrier_setup_user.id = carriers.carrier_setup
    ").joins("
      LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner
    ").joins("
      LEFT JOIN carrier_locations AS locations ON locations.id = carriers.head_office
    ").joins("
      LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id
    ").joins(
      'LEFT JOIN carr_new ON carr_new.mc_number = carriers.mc_number'
    ).limit(1)}

  scope :mine, ->(id) {where(:relationship_owner => id).select("
    carriers.*,
    (DATE(carriers.created_at) = DATE(CURRENT_DATE - 21)) AS three_weeks_lapse,
    contacts.primary_phone,
    contacts.primary_phone_type,
    contacts.primary_extension_number,
    contacts.primary_eligible_texting,
    contacts.secondary_phone,
    contacts.secondary_phone_type,
    contacts.secondary_extension_number,
    contacts.secondary_eligible_texting,
    contacts.email as contact_email,
    locations.city,
    locations.address,
    locations.state,
    locations.country,
    locations.loc_type,
    carr_new.loads_lw,
    carr_new.loads_2w,
    carr_new.loads_3w,
    carr_new.loads_4w,
    (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened,
    CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) as relationship_owner_name,
    CONCAT(carrier_setup_user.first_name, ' ', carrier_setup_user.last_name) as carrier_setup_name,
    CONCAT(contacts.first_name, ' ', contacts.last_name) as poc_name,
    (SELECT cnactivities.campaign_name FROM activities AS cnactivities WHERE cnactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS campaign_name,
    (SELECT atactivities.activity_type FROM activities AS atactivities WHERE atactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_type,
    (SELECT sactivities.status FROM activities AS sactivities WHERE sactivities.carrier_id =  carriers.id ORDER BY created_at DESC LIMIT 1) AS activity_status
    ").joins("
      LEFT JOIN users AS carrier_setup_user ON carrier_setup_user.id = carriers.carrier_setup
    ").joins("
      LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner
    ").joins("
      LEFT JOIN carrier_locations AS locations ON locations.id = carriers.head_office
    ").joins("
      LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id
    ").joins(
      'LEFT JOIN carr_new ON carr_new.mc_number = carriers.mc_number'
    )}

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

  def display_name_reminder
    if self.company_name.present? && self.company_name != "" && !self.company_name.nil?
      "<a href='/carriers/#{self.id}'>#{self.company_name}</a> (Carrier)"
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
