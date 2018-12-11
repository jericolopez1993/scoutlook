Then(/^go to the "([^"]*)" page$/) do |menu|
  click_link(menu)
end
And(/^there should be "([^"]*)" header title$/) do |header_title|
  within("/html/body/div/div[3]/div/div/div[1]/h4") do
      page.has_content?(header_title)
  end
end
When(/^I go to the new carrier page$/) do
  visit "/carriers/new"
end
And(/^add a carrier with these data$/) do |table|
  headers = table.headers
  tables = table.hashes
  tables.each do |tbl|
    headers.each do |hdr|
      if hdr == "sales_priority" || hdr == "contract_rates" || hdr == "total_fleet_size"
        select(tbl[hdr], :from => "carrier_#{hdr}")
      else
        fill_in "carrier_#{hdr}", :with => tbl[hdr]
      end
    end
  end
end
Then(/^there should be an success message "([^"]*)"$/) do |message|
  page.has_content?(message)
end
Then(/^submit the form$/) do
  find("//input[@type='submit']").click
end
And(/^the carrier "([^"]*)" should be added on the table$/) do |company_name|
    page.has_content?(company_name)
end
