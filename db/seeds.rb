# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Activity.all.each do |activity|
  if activity.annual_value == '0 - 5,000'
    activity.update_attributes(:annual_value => '0-5M')
  elsif activity.annual_value == '5,000 - 25,000'
    activity.update_attributes(:annual_value => '5-10M')
  elsif activity.annual_value == '25,000 - 50,000'
    activity.update_attributes(:annual_value => '10-25M')
  elsif activity.annual_value == '50,000 - 100,000'
    activity.update_attributes(:annual_value => '25-100M')
  elsif activity.annual_value == '100,000+'
    activity.update_attributes(:annual_value => '100M+')
  end
end
