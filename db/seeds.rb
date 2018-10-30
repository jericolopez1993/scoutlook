# Client.find(3).update_attributes(:head_office => 21)
#
# Location.all.each do |location|
#   location.update_attributes(:client_id => 3)
# end
#
# Location.find(21).update_attributes(:is_origin => true, :is_destination => true
# User.create!([
#   {id: 6, email: "test@marcelo.ph", password: "password", password_confirmation: "password", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, created_at: "2018-10-14 14:53:58", updated_at: "2018-10-27 20:33:03", first_name: "Test", middle_name: nil, last_name: "Contact", confirmation_token: nil, confirmed_at: "2018-10-14 14:53:58", confirmation_sent_at: nil, admin: false, client_contact_id: 12}
# ])
MasterInvoice.all.each do |invoice|
  if invoice.shipment_entry == "single shipment"
    invoice.update_attributes(:shipment_entry => 'Single')
  elsif invoice.shipment_entry == "multiple shipment"
    invoice.update_attributes(:shipment_entry => 'Multiple')
  end
end
