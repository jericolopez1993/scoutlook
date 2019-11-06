class CarrNew < ApplicationRecord
  self.table_name = "carr_new"

  scope :listings, -> {
    select("
      carr_new.*,
      carr_new.carrier_name AS company_name,
      (date_part('week', NOW()) - date_part('week', carr_new.first_load_date)) AS wk,
      carriers.id AS carrier_id,
      carriers.sales_priority,
      carriers.power_units,
      carriers.reefers,
      carriers.teams,
      carriers.teams,
      carriers.teams,
      carriers.interview,
      carriers.wolfbyte,
      carriers.c_auditable_last_activity_date,
      carriers.c_lane_origin,
      carriers.c_lane_destination,
      (SELECT date_opened FROM activities WHERE activities.carrier_id = carriers.id ORDER BY created_at DESC LIMIT 1) as date_opened,
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
      contacts.secondary_eligible_texting,
      contacts.email as contact_email,
      locations.city,
      locations.address,
      locations.state,
      locations.country,
      locations.loc_type"
    ).joins(
      'LEFT JOIN carriers ON carriers.mc_number = carr_new.mc_number'
    ).joins(
      "LEFT JOIN carrier_contacts AS contacts ON contacts.id = carriers.poc_id"
    ).joins(
      "LEFT JOIN users AS relationship_owner_user ON relationship_owner_user.id = carriers.relationship_owner"
    ).joins(
      "LEFT JOIN carrier_locations AS locations ON locations.id = carriers.head_office"
    )
}

  default_scope {listings}
end
