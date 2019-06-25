class CarrNew < ApplicationRecord
  self.table_name = "carr_new"

  scope :listings, -> {select("carr_new.*,
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
  ).joins('LEFT JOIN carriers ON CONCAT("MC", carriers.mc_number) = carr_new.mcnum').joins("LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id").joins("LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner")}

  default_scope {listings}
end
