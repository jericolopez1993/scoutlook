Client.find(3).update_attributes(:head_office => 21)

Location.all.each do |location|
  location.update_attributes(:client_id => 3)
end

Location.find(21).update_attributes(:is_origin => true, :is_destination => true)
