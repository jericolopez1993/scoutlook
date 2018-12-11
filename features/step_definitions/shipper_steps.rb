When(/^I go to the new shipper page$/) do
  visit "/shippers/new"
end
And(/^add a shipper with these data$/) do |table|
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      if hdr == "sales_priority" || hdr == "shipper_type" || hdr == "loads_per_month" || hdr == "spend_per_year" || hdr == "buying_criteria" || hdr == "price_sensitivity"
        select(tbl[hdr], :from => "shipper_#{hdr}")
      else
        fill_in "shipper_#{hdr}", :with => tbl[hdr]
      end
    end
  end
end
And(/^the shipper "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
And(/^edit the shipper with these data$/) do |table|
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      if hdr == "sales_priority" || hdr == "shipper_type" || hdr == "loads_per_month" || hdr == "spend_per_year" || hdr == "buying_criteria" || hdr == "price_sensitivity"
        select(tbl[hdr], :from => "shipper_#{hdr}")
      else
        fill_in "shipper_#{hdr}", :with => tbl[hdr]
      end
    end
  end
end
