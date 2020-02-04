class Activity < ApplicationRecord
  audited
  after_save :update_computed_data
  has_many_attached :proposal_pdf
  has_one_attached :credit_application
  before_save :set_open_and_close_date
  belongs_to :carrier_contact, optional: true
  belongs_to :shipper_contact, optional: true
  belongs_to :user, optional: true
  belongs_to :carrier, optional: true
  belongs_to :shipper, optional: true
  has_many :rate, :dependent => :delete_all
  has_many :reminders, :dependent => :delete_all

  scope :listings, -> {select("
    activities.*,
    CONCAT(users.first_name, ' ', users.last_name) as user_name,
    COALESCE(carrier_locations.state, shipper_locations.state) as location_state,
    COALESCE(carriers.company_name, shippers.company_name) as current_name,
    carriers.company_name as carrier_name,
    shippers.company_name as shipper_name
    ").joins("
      LEFT JOIN users ON users.id = activities.user_id
    ").joins("
      LEFT JOIN carriers ON carriers.id = activities.carrier_id
    ").joins("
      LEFT JOIN shippers ON shippers.id = activities.shipper_id
    ").joins("
      LEFT JOIN carrier_locations ON carrier_locations.id = carriers.head_office
    ").joins("
      LEFT JOIN shipper_locations ON shipper_locations.id = shippers.head_office
    ")}

  def update_computed_data
    ComputeDataService.new.reminder(self.carrier_id)
  end

  def display_name
    if !self.carrier.nil?
      "Carrier Activity to #{self.carrier.display_name}"
    elsif !self.shipper.nil?
      "Shipper Activity to #{self.shipper.display_name}"
    else
      "<a href='/activities/#{self.id}'>Activity</a>"
    end
  end

  def display_select_name
    display_name = ""
    if self.user
      display_name = self.user.full_name
    end
    if self.user && (self.carrier || self.shipper)
       display_name = display_name + " @ "
    end
    if self.carrier
      display_name = display_name + (!self.carrier.company_name.nil? ? self.carrier.company_name : "(no name)")
    elsif self.shipper
      display_name = display_name + (!self.shipper.company_name.nil? ? self.shipper.company_name : "(no name)")
    end
    if !display_name.blank?
      display_name = display_name + " - "
    end
    display_name + "#{self.activity_type} (#{self.status ? 'Open' : 'Closed'})"
  end

  def set_open_and_close_date
    if self.status
      self.date_opened = Time.now.getutc
    else
      self.date_closed = Time.now.getutc
    end
  end


end
