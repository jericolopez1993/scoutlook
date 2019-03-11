CarrierContact.where(:primary_phone_type => "Work").each do |contact|
  contact.update_attributes(:primary_phone_type => "Land Line")
end
CarrierContact.where(:secondary_phone_type => "Work").each do |contact|
  contact.update_attributes(:secondary_phone_type => "Land Line")
end

ShipperContact.where(:primary_phone_type => "Work").each do |contact|
  contact.update_attributes(:primary_phone_type => "Land Line")
end
ShipperContact.where(:secondary_phone_type => "Work").each do |contact|
  contact.update_attributes(:secondary_phone_type => "Land Line")
end
