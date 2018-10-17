# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Activity.all.each do |activity|
#   if activity.annual_value == '0 - 5,000'
#     activity.update_attributes(:annual_value => '0-5M')
#   elsif activity.annual_value == '5,000 - 25,000'
#     activity.update_attributes(:annual_value => '5-10M')
#   elsif activity.annual_value == '25,000 - 50,000'
#     activity.update_attributes(:annual_value => '10-25M')
#   elsif activity.annual_value == '50,000 - 100,000'
#     activity.update_attributes(:annual_value => '25-100M')
#   elsif activity.annual_value == '100,000+'
#     activity.update_attributes(:annual_value => '100M+')
#   end
# end
Location.destroy_all
Location.create!([
  {name: "Listowel", address: "5701 Line 84", city: "Listowel", state: "Ontario", postal: "N4W 3G9", country: "Canada"},
  {name: "Toronto", address: "1031 Hubrey Rd", city: "Toronto", state: "Ontario", postal: "N6N1B4", country: "Canada"},
  {name: "Mississauga", address: "6230 Shawson Dr", city: "Mississauga", state: "Ontario", postal: "L5T1J8", country: "Canada"},
  {name: "Grand-Falls Windsor", address: "6 Earle St", city: "Grand-Falls Windsor", state: "Newfoundland", postal: "A2B1H5", country: "Canada"},
  {name: "Winnipeg", address: "1695 Sargent Ave", city: "Winnipeg", state: "Manitoba", postal: "R3H0C4", country: "Canada"},
  {name: "Levis", address: "1720 Boul Guillaume-Couture", city: "Levis", state: "Quebec", postal: "G6W5M6", country: "Canada"},
  {name: "Moncton", address: "50 Delong Dr", city: "Moncton", state: "New Brunswick", postal: "E1E4G3", country: "Canada"},
  {name: "Lloydminster", address: "4180 62", city: "Lloydminster", state: "Alberta", postal: "T9V2E9", country: "Canada"},
  {name: "Repentigny", address: "611 Rue Lavoisier", city: "Repentigny", state: "Quebec", postal: "J6A7N2", country: "Canada"},
  {name: "Yarmouth", address: "603 Main St.", city: "Yarmouth", state: "Nova Scotia", postal: "B5A1K1", country: "Canada"},
  {name: "Oro-Medonte", address: "3 Small Cres", city: "Oro-Medonte", state: "Ontario", postal: "L0L1T0", country: "Canada"},
  {name: "Saint John", address: "55 Watertower Rd.", city: "Saint John", state: "New Brunswick", postal: "E2M7K2", country: "Canada"},
  {name: "Thetford Mines", address: "470 Rue Saint-Alphonse", city: "Thetford Mines", state: "Quebec", postal: "G6G3V8", country: "Canada"},
  {name: "Burnaby", address: "5325 Still Creek Ave.", city: "Burnaby", state: "British Columbia", postal: "V5C5V1", country: "Canada"},
  {name: "Magog", address: "1875 Boul Industriel", city: "Magog", state: "Quebec", postal: "J1X5N4", country: "Canada"},
  {name: "Rouyn-Noranda", address: "185 Boul Industriel", city: "Rouyn-Noranda", state: "Quebec", postal: "J9X6P2", country: "Canada"},
  {name: "Val-d'Or", address: "85 Rue Des Distributeurs", city: "Val-d'Or", state: "Quebec", postal: "J9P6Y1", country: "Canada"},
  {name: "Moncton", address: "80 Rue J.A.-Bombardier", city: "Boucherville", state: "Quebec", postal: "J4B8N4", country: "Canada"}
])
