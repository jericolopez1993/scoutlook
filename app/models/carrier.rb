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
  has_many :adm, -> { where(adm: true).order("id DESC")}, primary_key: "id", foreign_key: 'carrier_id', class_name: "CarrierContact"

  has_one :origin_location, primary_key: "origin", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :destination_location, primary_key: "destination", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :head_office_location, primary_key: "head_office", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :location, primary_key: "head_office", foreign_key: 'id', class_name: "CarrierLocation"
  has_one :poc, primary_key: "poc_id", foreign_key: 'id', class_name: "CarrierContact"
  has_one :pdm, primary_key: "pdm_id", foreign_key: 'id', class_name: "CarrierContact"

  BLUE = ["NY", "NY-Brooklyn", "NY-Bronx",]
  LIGHT_BLUE = ["AL", "AK", "AR", "CO", "CT", "DE", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
  "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NJ", "NV", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD",
  "TN", "UT", "VT", "VA", "WV", "WI", "WY",]
  DARK_BLUE = ["US-Northeast", "US-Northeast (No Bronx)", "US-Southeast", "US-Northwest", "US-Midwest",]
  BROWN = ["TX",]
  ORANGE = ["CA", "AZ",]
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
    if activity_ids != ''
       Rate.where("activity_id IN (#{activity_ids})")
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
