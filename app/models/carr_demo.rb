class CarrDemo < ApplicationRecord
  self.table_name = "carr_demo"

  scope :listings, -> {select("
    carr_demo.*,
    carriers.id AS carrier_id,
    carriers.sales_priority,
    CONCAT(relationship_owner_user.first_name, ' ', relationship_owner_user.last_name) AS relationship_owner_name,
    carriers.relationship_owner AS user_id,
    CONCAT(contacts.first_name, ' ', contacts.last_name) AS poc_name,
    contacts.primary_phone,
    contacts.primary_phone_type,
    contacts.primary_extension_number,
    contacts.primary_eligible_texting,
    contacts.secondary_phone,
    contacts.secondary_phone_type,
    contacts.secondary_extension_number,
    contacts.secondary_eligible_texting"
  ).joins('
    LEFT JOIN carriers ON carriers.mc_number = carr_demo.mc_number
    ').joins("
    LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id
    ").joins("
    LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner
    ")}

  default_scope {listings}

  def assigned_carrier
    Carrier.find(self['carrier_id']) if self['carrier_id']
  end
end
