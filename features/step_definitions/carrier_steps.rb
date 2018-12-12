Then(/^go to the "([^"]*)" page$/) do |menu|
 visit "/#{menu.downcase}"
end
And(/^there should be "([^"]*)" header title$/) do |header_title|
  within(:xpath, "/html/body/div/div[3]/div/div/div[1]/h4") do
      expect(page).to have_content(header_title)
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
  expect(page).to have_content(message)
end
Then(/^submit the form$/) do
  find("//input[@type='submit']").click
end
And(/^the carrier "([^"]*)" should be on the show page$/) do |company_name|
    expect(page).to have_content(company_name)
end
When(/^I clicked the edit button$/) do
  click_link('Edit')
end
And(/^edit the carrier with these data$/) do |table|
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
When(/^I clicked the delete button$/) do
  click_link('Delete')
end
Then(/^there should not have "([^"]*)" on the table$/) do |name|
  expect(page).to have_no_content(name)
end
